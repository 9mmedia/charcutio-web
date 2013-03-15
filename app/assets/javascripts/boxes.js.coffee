# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
data = []

sensor_types =
  temperature: "Temperature (C)"
  humidity: "Humidity (%)"
  weight: "Weight (g)"

relay_types =
  temperature: "Freezer (0: off, 100: on)"
  humidity: "Humidifier (0: off, 100: on)"

secondary_relay_types =
  humidity: "Dehumidifier (0: off, 100: on)"

createRow = (tuple, column_count) ->
  row = [new Date(tuple.time * 1000), tuple.value]
  if column_count > 2
    row.push tuple.relay0
  if column_count > 3
    row.push tuple.relay1
  row

drawChart = (json) ->
  table = new google.visualization.DataTable()
  table.addColumn('datetime', 'Time')
  table.addColumn('number', sensor_types[json["type"]])
  if relay_types[json["type"]]
    table.addColumn('number', relay_types[json["type"]])
  if secondary_relay_types[json["type"]]
    table.addColumn('number', secondary_relay_types[json["type"]])
  column_count = table.getNumberOfColumns()
  rows = for tuple in json.data
    createRow(tuple, column_count)
  table.addRows(rows)
  options =
    title: json.type
    hAxis:
      format: "M/d/yy h:mm a"
      slantedText: true
      textStyle:
        fontSize: 10
  data = json.data
  chart = new google.visualization.LineChart(document.getElementById('rendered-graph'))
  chart.draw(table, options)

updateChart = (json) ->
  json.data.push data...
  drawChart(json)

loadData = () ->
  boxId = $("#graph").data("boxId")
  span = $("#graph").data("graphSpan")
  type = $("#graph").data("graphType")
  if (data.length > 0)
    $.getJSON("/boxes/#{boxId}/data_since/#{type}", { since: data[0].time }, updateChart)
  else
    $.getJSON("/boxes/#{boxId}/data/#{type}", { span: span }, drawChart)

initialLoad = () ->
  loadData()

google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(initialLoad)

setInterval loadData, 15000

$(->
  $(".graph-type a").click((e) ->
    data = []
    newType = $(this).data("type")
    $("#graph").data("graphType", newType)
    loadData()
  )

  $(".time a").click((e) ->
    data = []
    newSpan = $(this).data("span")
    $("#graph").data("graphSpan", newSpan)
    loadData()
  )
)


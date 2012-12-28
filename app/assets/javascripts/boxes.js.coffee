# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

types =
  temp: "Temperature (F)"
  humidity: "Humidity (%)"
  weight: "Weight (lbs)"

drawChart = (json) ->
  table = new google.visualization.DataTable()
  table.addColumn('datetime', 'Time')
  table.addColumn('number', types[json["type"]])
  tuples = json.data
  rows = for tuple in tuples
    [new Date(tuple.time * 1000), tuple.value]
  table.addRows(rows)
  options =
    title: json.type
    hAxis:
      format: "M/d/yy h:mm a"
      slantedText: true
      textStyle:
        fontSize: 10

  chart = new google.visualization.LineChart(document.getElementById('rendered-graph'))
  chart.draw(table, options)

loadData = () ->
  boxId = $("#graph").data("boxId")
  span = $("#graph").data("graphSpan")
  type = $("#graph").data("graphType")
  $.getJSON("/boxes/#{boxId}/data/#{type}", { span: span }, drawChart)

initialLoad = () ->
  loadData()

google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(initialLoad)

$(->
  $(".graph-type a").click((e) ->
    newType = $(this).data("type")
    $("#graph").data("graphType", newType)
    loadData()
  )

  $(".time a").click((e) ->
    newSpan = $(this).data("span")
    $("#graph").data("graphSpan", newSpan)
    loadData()
  )
)


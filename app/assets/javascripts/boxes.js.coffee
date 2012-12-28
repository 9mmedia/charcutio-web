# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

types =
  temp: "Temperature (F)"
  humidity: "Humidity (%)"
  weight: "Weight (lbs)"

buildDataTable = (json) ->
  table = new google.visualization.DataTable()
  formatter = new google.visualization.DateFormat(
    formatType: "short"
    #pattern: "M/d/yy h:mm"
  )
  table.addColumn('datetime', 'Time')
  table.addColumn('number', types[json["type"]])
  tuples = json.data
  rows = for tuple in tuples
    [new Date(tuple.time * 1000), tuple.value]
  table.addRows(rows)
  #formatter.format(table,0)
  options =
    title: json.type
    hAxis:
      format: "M/d/yy h:mm a"
      slantedText: true
      textStyle:
        fontSize: 10

  chart = new google.visualization.LineChart(document.getElementById('graph'))
  chart.draw(table, options)

drawChart = (type) ->
  $.getJSON("/boxes/1/data/#{type}", buildDataTable)

initialLoad = () ->
  drawChart("temp")

google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(initialLoad)

$(->
  $("#temp-tab a").click((e) ->
    drawChart("temp"))
  $("#humidity-tab a").click((e) ->
    drawChart("humidity"))
  $("#weight-tab a").click((e) ->
    drawChart("weight"))
)


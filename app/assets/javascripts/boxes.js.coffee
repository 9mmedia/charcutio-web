# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

buildDataTable = (json) ->
  table = new google.visualization.DataTable()
  table.addColumn('datetime', 'Time')
  table.addColumn('number', 'Temperature (F)')
  tuples = json.data
  rows = for tuple in tuples
    [new Date(tuple.time * 1000), tuple.value]
  table.addRows(rows)
  options =
    title: json.type
    vAxis:
      minValue: 40

  chart = new google.visualization.LineChart(document.getElementById('graph'))
  chart.draw(table, options)

drawChart = () ->
  $.getJSON('/boxes/1/data/temp', buildDataTable)
  #options =
    #title: "Test Chart"
    #vAxis:
      #minValue: 40

  #chart = new google.visualization.LineChart(document.getElementById('graph'))
  #chart.draw(data, options)


google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(drawChart)


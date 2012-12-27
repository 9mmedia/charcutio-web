# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

buildDataTable = (json) ->
drawChart = () ->
  data = new google.visualization.DataTable()
  data.addColumn('datetime', 'Date')
  data.addColumn('number', 'Value')
  data.addRows([
    [new Date(2012,12,25),45.6 ],
    [new Date(2012,12,26),50.7],
    [new Date(2012,12,27), 52.3],
    [new Date(2012,12,28), 55.2]
  ])
  options =
    title: "Test Chart"
    vAxis:
      minValue: 40

  chart = new google.visualization.LineChart(document.getElementById('graph'))
  chart.draw(data, options)


google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(drawChart)


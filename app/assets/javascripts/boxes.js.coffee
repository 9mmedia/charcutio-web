# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
data = []
chart = {}

sensor_types =
  temperature: "Temperature (C)"
  humidity: "Humidity (%)"
  weight_0: "Weight 1"
  weight_1: "Weight 2"
  weight_2: "Weight 3"

relay_types =
  temperature: "Freezer (0: off, 100: on)"
  humidity: "Humidifier (0: off, 100: on)"

secondary_relay_types =
  humidity: "Dehumidifier (0: off, 100: on)"

createRow = (tuple, column_count) ->
  row = [tuple.time * 1000, tuple.value]
  if column_count > 2
    row.push tuple.relay0
  if column_count > 3
    row.push tuple.relay1
  row

drawChart = (json) ->
  data = json.data
  chartData = for point in data #[data.length-1..0] by -1
     createRow(point, 1) if point.value
  chart = new Highcharts.Chart({
      chart: {
          renderTo: 'rendered-graph',
          type: 'spline',
          zoomType: 'x',
          spacingRight: 20
      },
      title: {
          text: ''
      },
      subtitle: {
              ''
      },
      xAxis: {
          type: 'datetime',
          title: {
              text: null
          }
      },
      yAxis: {
          title: {
              text: ''
          },
          plotLines: [{
              value: 0,
              width: 1,
              color: '#880000'
          }],
          showFirstLabel: false
      },
      tooltip: {
          shared: true
      },
      legend: {
          enabled: false  
      },
      plotOptions: {
        spline: {
          lineWidth: 1,
          states: {
              hover: {
                  lineWidth: 2
              }
          },
          marker: {
              enabled: false,
              states: {
                  hover: {
                      enabled: true,
                      symbol: 'circle',
                      radius: 5,
                      lineWidth: 1
                  }
              }
          }
        }
      },

      series: [{
          name: '',
          data: chartData
      }]
  })

updateChart = (json) ->
  if json.data.length > 0
    data.push json.data...
    for tuple in json.data
      chart.series[0].addPoint(createRow(tuple, 1),true,true)

loadData = () ->
  boxId = $("#graph").data("boxId")
  span = $("#graph").data("graphSpan")
  type = $("#graph").data("graphType")
  if (data.length > 0)
    $.getJSON("/boxes/#{boxId}/data_since/#{type}", { since: data[data.length-1].time }, updateChart)
  else
    $.getJSON("/boxes/#{boxId}/data/#{type}", { span: span }, drawChart)

initialLoad = () ->
  loadData()

google.load("visualization", "1", {packages:["corechart"]})
google.setOnLoadCallback(initialLoad)

setInterval loadData, 5000

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


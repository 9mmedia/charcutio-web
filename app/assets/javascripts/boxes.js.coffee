# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
data = []
relay_data = []
chart = {}
interval = 0

boxId = $("#graph").data("boxId")
span = $("#graph").data("graphSpan")
type = $("#graph").data("graphType")

sensor_types =
  temperature: "Temperature (C)"
  humidity: "Humidity (%)"
  weight_0: "Weight 1"
  weight_1: "Weight 2"
  weight_2: "Weight 3"

relays =
  temperature: ["freezer"]
  humidity: ["humidifier","dehumidifier"]

createRow = (tuple) ->
  row = [tuple.time * 1000, tuple.value]

seriesForType = (type) ->
  for series in chart.series
    return series if series.name == type
  return false

drawChart = (json) ->
  data = for point in json.data
     createRow(point)
  chart.destroy() if chart
  chart = new Highcharts.Chart(
    chart:
      renderTo: 'rendered-graph'
      zoomType: 'x'
      spacingRight: 20
    title:
      text: type
    xAxis:
        type: 'datetime'
        title:
          text: null
    yAxis:[
      title:
        text: ''
      plotLines: [
        value: 0
        width: 1
        color: '#880000'
      ]
      showFirstLabel: false
      {
      title:
        text: ''  
      max: 50
      min: 0
      labels:
        enabled: false
      }
      ]
    tooltip:
      shared: true
    legend:
      enabled: true  
    plotOptions:
      spline:
        lineWidth: 1,
        states:
          hover:
            lineWidth: 1
        marker:
          enabled: false
          states:
            hover:
              enabled: true
              symbol: 'circle'
              radius: 5,
              lineWidth: 1
      area:
        lineWidth:0
        fillOpacity: .1
        marker:
          enabled: false
    series: [
      name: type,
      type: "spline"
      data: data
    ]
  )
  interval = setInterval updateData,   5000

resetRelays = () ->
  relay_data = {}

drawRelaySeries = (json) ->
  #this is hack for when relay comes back before chart is drawn
  if !chart
    setTimeout(()->
      drawRelaySeries(json)
    ,500)  
  else
    relay_data[json.type] = for tuple in json.data
      createRow(tuple)
    chart.addSeries(
      name: json.type
      type: 'area'
      data: relay_data[json.type]
      yAxis: 1
      )

updateRelaySeries = (json) ->
  if json.data.length>0
    for tuple in json.data
      point = createRow(tuple)
      seriesForType(json.type).addPoint(point)
      relay_data[json.type].push point

updateChart = (json) ->
  if json.data.length > 0
    for tuple in json.data
      point = createRow(tuple)
      seriesForType(type).addPoint(point,true,true)
      data.push point

loadData = () ->
  chart = null
  resetRelays()
  clearInterval interval
  $.getJSON("/boxes/#{boxId}/data/#{type}", { span: span }, drawChart)
  if relays[type]
    for relay_type in relays[type]
      $.getJSON("/boxes/#{boxId}/data/#{relay_type}", { span: span }, drawRelaySeries)

updateData = () ->
  latest_point = if data.length>0 then   data[data.length-1][0]/1000 else 0
  since = Math.max(Math.floor(new Date().getTime()/1000)-60,latest_point)
  $.getJSON("/boxes/#{boxId}/data_since/#{type}", { since: since }, updateChart)
  if relays[type]
    for relay_type in relays[type]
      _relay_data = relay_data[relay_type]
      latest_point = if _relay_data.length>0 then _relay_data[_relay_data.length-1][0]/1000 else 0
      since = Math.max(Math.floor(new Date().getTime()/1000)-60,latest_point)
      $.getJSON("/boxes/#{boxId}/data_since/#{relay_type}", { since: since }, updateRelaySeries)

$(document).ready ->
  loadData()

$(->
  $(".graph-type a").click((e) ->
    data = []
    type = $(this).data("type")
    $("#graph").data("graphType", type)
    loadData()
  )

  $(".time a").click((e) ->
    data = []
    span = $(this).data("span")
    $("#graph").data("graphSpan", span)
    loadData()
  )
)


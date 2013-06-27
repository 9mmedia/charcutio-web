#= require application
#= require_tree .
#= require_self

# document.write('<div id="ember-testing-container"><div id="ember-testing"></div></div>')

#CharcutioWeb.rootElement = '#ember-testing'
CharcutioWeb.setupForTesting()
CharcutioWeb.injectTestHelpers()

window.exists = (selector) ->
  !!find(selector).length

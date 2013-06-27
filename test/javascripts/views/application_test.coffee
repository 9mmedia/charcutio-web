module "/conversations",
  setup: ->
    Ember.run CharcutioWeb, CharcutioWeb.advanceReadiness

  teardown: ->
    CharcutioWeb.reset()


test "/", ->
  expect 2

  visit("/").then ->
    ok(exists("h1"), "The header was rendered")
    ok(exists("p"), "The paragraph was rendered")

# Example showing click with promises to check next view
# From: https://github.com/ebryn/bloggr-client-rails/
# 
# test("/posts/:post_id", function() {
#   expect(4);
# 
#   visit("/posts").then(function() {
#     return click("td a:first");
#   }).then(function() {
#     equal(find(".span9 h1").text(), "zomg", "The post title was rendered");
#     ok(exists(".span9 h2:contains(by ebryn)"), "The post author was rendered");
#     equal(find(".span9 .intro").text().trim(), "zomg", "The post intro was rendered");
#     equal(find(".span9 .below-the-fold").text().trim(), "ZOMG ZOMG ZOMG ZOMG", "The post intro was rendered");
#   })
# });
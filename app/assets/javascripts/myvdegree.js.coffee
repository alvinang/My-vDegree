window.Myvdegree =
  Models: {}
  Collections: {}
  Views: {}
  Routers: {}
  initialize: ->
    new Myvdegree.Routers.Courses
    Backbone.history.start({pushState: true, root: 'dashboard/index'})

$(document).ready ->
  Myvdegree.initialize()

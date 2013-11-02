class Myvdegree.Views.CoursesIndex extends Backbone.View

  template: JST['courses/index']

  render: ->
    $(@el).html(@template())
    @

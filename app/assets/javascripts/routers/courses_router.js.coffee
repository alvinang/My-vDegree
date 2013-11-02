class Myvdegree.Routers.Courses extends Backbone.Router

  routes:
    '': 'index'

  index: ->
    view = new Myvdegree.Views.CoursesIndex()
    $('.backbone').html(view.render().el)
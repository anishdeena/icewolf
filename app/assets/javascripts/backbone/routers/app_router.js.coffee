class Icewolf.Routers.AppsRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ".*": "splash"
    "home": "home"
  
  splash: ->
    @view = new Icewolf.Views.Apps.SplashView()
    $("#base").html(@view.render().el)

  home: ->
    @view = new Icewolf.Views.Apps.HomeView()
    $("#base").html(@view.render().el)


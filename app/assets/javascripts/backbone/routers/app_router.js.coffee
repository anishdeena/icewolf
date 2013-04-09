class Icewolf.Routers.AppsRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ".*"      : "splash"
    "follow"  : "follow"
    "home"    : "home"
  
  splash: ->
    @view = new Icewolf.Views.Apps.SplashView()
    $("#base").html(@view.render().el)

  follow: ->
    @view = new Icewolf.Views.Apps.FollowView()
    $("#base").html(@view.render().el)

  home: ->
    @view = new Icewolf.Views.Apps.HomeView()
    $("#base").html(@view.render().el)


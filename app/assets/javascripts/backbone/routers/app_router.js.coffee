class Icewolf.Routers.AppsRouter extends Backbone.Router
  initialize: (options) ->

  routes:
    ".*"      : "splash"
    "follow"  : "follow"
    "home"    : "home"
    "bookmarks/:id" : "bookmarks"
  
  renderTopBar: ->
    @view = new Icewolf.Views.Apps.TopBarView()
    $("#topBar").html(@view.render().el)    

  splash: ->
    @view = new Icewolf.Views.Apps.SplashView()
    $("#base").html(@view.render().el)

  follow: ->
    @view = new Icewolf.Views.Apps.FollowView()
    $("#base").html(@view.render().el)

  home: ->
    if $('#mainPane').length == 0
      $("#base").html('<div id="topBar"></div><div id="mainPane"></div>')
      @renderTopBar()
    $("#mainPane").fadeOut()
    @view = new Icewolf.Views.Apps.HomeView()
    $("#mainPane").html(@view.render().el)
    $("#mainPane").fadeIn()
    
  bookmarks: (id) ->
    if $('#mainPane').length == 0
      $("#base").html('<div id="topBar"></div><div id="mainPane"></div>')
      @renderTopBar()
    $("#mainPane").fadeOut()
    @view = new Icewolf.Views.Apps.BookmarkView(id: id)
    $("#mainPane").html(@view.render().el)
    $("#mainPane").fadeIn()


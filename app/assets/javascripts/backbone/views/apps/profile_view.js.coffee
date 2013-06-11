Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.ProfileView extends Backbone.View
  template          : JST["backbone/templates/apps/profile_home"]
  template_bookmark : JST["backbone/templates/apps/bookmark"]
  offset = 0
  
  events:
    "click a.userlink"  : "redirectToUser"
  
  constructor: (options) ->
    super(options)
    @id = options.id
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark_view = new Icewolf.Views.Apps.BookmarkView(id: @id)
    @cookie = new Cookie()
    @errors = new Errors()
    
  redirectToUser: (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $(e.currentTarget).attr('uid')
    router.navigate("bookmarks/" + id,{trigger : true}) 

  render: ->
    @user.fetch(
      url: '/user/' + @id
      success: (model, resp) =>
        $(@el).html(@template(user: this.user))
        @$('#mainbox').html(@bookmark_view.render().el)
      error: =>
    )

    return this

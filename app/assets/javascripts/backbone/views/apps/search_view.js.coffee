Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.SearchView extends Backbone.View
  template: JST["backbone/templates/apps/home"]
  template_bookmark: JST["backbone/templates/apps/bookmark"]
  
  events:
    "click a.userlink"  : "redirectToUser"
  
  constructor: (options) ->
    super(options)
    @search_term = null
    if options
      if options.hasOwnProperty('search_term')
        @search_term = options.search_term
    @offset = 0
    @options_hash = {}
    @params_hash = {'options': @options_hash}
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark_view = new Icewolf.Views.Apps.BookmarkView(search_term: @search_term)
    @cookie = new Cookie()
    @errors = new Errors()
  
  redirectToUser: (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $(e.currentTarget).attr('uid')
    router.navigate("bookmarks/" + id,{trigger : true}) 

  render: ->
    $(@el).html('<div id="mainbox"></div>')
    $("#bookmarkTagsInput", @el).tagsInput()
    $('#addBookmarkPopup', @el).hide()
    @$('#mainbox').html(@bookmark_view.render().el)
    return this

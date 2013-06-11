Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.BookmarkView extends Backbone.View
  template          : JST["backbone/templates/apps/bookmark_container"]
  template_bookmark : JST["backbone/templates/apps/bookmark"]
  offset = 0
  
  events:
    "click a.userlink"  : "redirectToUser"
  
  constructor: (options) ->
    super(options)
    @options_hash = {}
    @params_hash = {'options': @options_hash}
    if options
      if options.hasOwnProperty('id')
        @id = options.id
      if options.hasOwnProperty('search_term')
        @search_term = options.search_term  
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    @initializeOptions()
    
  initializeOptions: () ->
    @options_hash['offset'] = @offset
    if @search_term
      @options_hash['search_term'] = @search_term
    if @id
      @options_hash['credential_id'] = @id
      
  redirectToUser: (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $(e.currentTarget).attr('uid')
    router.navigate("bookmarks/" + id,{trigger : true}) 
    
  getBookmarks: () ->
    @bookmark_collection.fetch(
      data: @params_hash
      url : 'bookmarks'
      success: (model, resp) =>
        @offset = @bookmark_collection.models[0].attributes.offset
        @bookmark_collection.models[0].attributes.bookmark_collection.forEach((bookmark) =>
          $('.bookmark_container', @el).append(@template_bookmark(bookmark: bookmark.bookmark, article: bookmark.article, article_stats: bookmark.article_stats, user: bookmark.user))
        )
      error: () =>
        alert('Error fetching my bookmarks!')
    )

  render: ->
    $(@el).html(@template())
    @getBookmarks()
    return this

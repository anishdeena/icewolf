Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
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
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    @initializeOptions()
    
  initializeOptions: () ->
    @options_hash['offset'] = @offset
    if @search_term
      @options_hash['search_term'] = @search_term
  
  redirectToUser: (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $(e.currentTarget).attr('uid')
    router.navigate("bookmarks/" + id,{trigger : true}) 

  render: ->
    @user.fetch(
      success: (model, resp) =>
        appConstants.CURRENTUSER = this.user
        $(@el).html('<div id="mainbox"></div>')
        $("#bookmarkTagsInput", @el).tagsInput()
        $('#addBookmarkPopup', @el).hide()
        console.log(model)
        @bookmark_collection.fetch(
          data: @params_hash
          url : 'bookmarks'
          success: (model, resp) =>
            #console.log('hi')
            #console.log(JSON.stringify(@bookmark_collection))
            @offset = @bookmark_collection.models[0].attributes.offset
            @bookmark_collection.models[0].attributes.bookmark_collection.forEach((bookmark) =>
              @$('#mainbox').append(@template_bookmark(bookmark: bookmark.bookmark, article: bookmark.article, article_stats: bookmark.article_stats, user: bookmark.user))
            )
          error: () =>
            alert('Error fetching my bookmarks!')
        )
      error: =>
    )
    return this

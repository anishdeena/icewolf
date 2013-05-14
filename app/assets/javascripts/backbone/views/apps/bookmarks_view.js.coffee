Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.BookmarkView extends Backbone.View
  template_bookmark: JST["backbone/templates/apps/bookmark"]
  offset = 0
  
  events:
    "click a.userlink"  : "redirectToUser"
  
  constructor: (options) ->
    super(options)
    @id = options.id
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    
  redirectToUser: (e) ->
    e.stopPropagation()
    e.preventDefault()
    id = $(e.currentTarget).attr('uid')
    router.navigate("bookmarks/" + id,{trigger : true}) 
    
  getBookmarks: () ->
    $('#mainbox', @el).html('')
    @bookmark_collection.fetch(
      url: '/bookmarks/' + @id
      success: (model, resp) =>
        #console.log(JSON.stringify(@bookmark_collection))
        @bookmark_collection.models.forEach((bookmark)=>
          $('#mainbox', @el).append(@template_bookmark(bookmark: bookmark.attributes.bookmark, article: bookmark.attributes.article, article_stats: bookmark.attributes.article_stats, user: bookmark.attributes.user))
        )
      error: () =>
        alert('Error fetching my bookmarks!')
    )

  render: ->
    $(@el).html('<div id="mainbox"></div>')
    @getBookmarks()
    return this

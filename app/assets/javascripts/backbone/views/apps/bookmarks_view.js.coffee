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
    $(@el).html('<div id="leftpane" style="margin-right: 10px;overflow: hidden;float: left;background-color: #34495e;color: white;"><div class="demo-browser-side"><div><img style="" src="http://graph.facebook.com/100004133943578/picture?width=111&amp;height=100"></div><div class="demo-browser-action"><a class="btn btn-danger btn-large btn-block" href="http://twitter.com/monstercritic" target="_blank">Follow</a></div><h5>@monstercritic</h5><h6>Tourist. Designer. NYC<a href="http://shmidt.in" target="_blank">shmidt.in</a></h6></div></div><div id="mainbox" style="overflow: hidden;"></div>')
    @getBookmarks()
    return this

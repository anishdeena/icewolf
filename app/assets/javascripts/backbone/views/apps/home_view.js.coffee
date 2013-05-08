Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
  template: JST["backbone/templates/apps/home"]
  template_bookmark: JST["backbone/templates/apps/bookmark"]
  
  events:
    "click #submitBtn"      : "saveBookmark"
    "click #addBookmarkBtn" : "toggleBookmarkPopup"
    "click #myBookmarksBtn" : "getMyBookmarks"
  
  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    
  saveBookmark: (e) ->
    @bookmark.save({url: @$('#urlbox').val(), comment: @$('#commentbox').val()}
      success: (model, resp) =>
        console.log(JSON.stringify(@bookmark))
        alert('Bookmark Saved!')
      error: () =>
        alert('Bookmark Save Error!')
    )
    
  getMyBookmarks: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @bookmark_collection.fetch(
      url: '/bookmarks/' + @user.attributes.credential_id
      success: (model, resp) =>
        console.log('hi')
        console.log(JSON.stringify(@bookmark_collection))
        @bookmark_collection.models.forEach((bookmark)=>
          @$('#mainbox').append(@template_bookmark(bookmark: bookmark.attributes.bookmark, article: bookmark.attributes.article, user: bookmark.attributes.user))
        )
      error: () =>
        alert('Error fetching my bookmarks!')
    )
  
  toggleBookmarkPopup: (e) ->
    e.stopPropagation()
    e.preventDefault()
    $('#addBookmarkPopup').toggle()  

  render: ->
    @user.fetch(
      success: (model, resp) =>
        $(@el).html(@template(user: this.user))
        $("#bookmarkTagsInput", @el).tagsInput()
        $('#addBookmarkPopup', @el).hide()
        console.log(model)
      error: =>
    )
    return this

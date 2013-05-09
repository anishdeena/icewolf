Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
  template: JST["backbone/templates/apps/home"]
  template_bookmark: JST["backbone/templates/apps/bookmark"]
  
  offset = 0
  
  events:
    "click #submitBtn"      : "saveBookmark"
    "click #addBookmarkBtn" : "toggleBookmarkPopup"
    "click #myBookmarksBtn" : "getMyBookmarks"
    "click #logoBtn"        : "gotoHome"
  
  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    
  gotoHome: (e) ->
    e.stopPropagation()
    e.preventDefault()
    router.navigate("home",{trigger : true})    
    
  saveBookmark: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @bookmark.save({url: @$('#urlbox').val(), comment: @$('#commentbox').val()}
      success: (model, resp) =>
        #console.log(JSON.stringify(@bookmark))
        #alert('Bookmark Saved!')
        $('#addBookmarkPopup').hide()
      error: () =>
        alert('Bookmark Save Error!')
    )
    
  getMyBookmarks: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @$('#mainbox').html('')
    @bookmark_collection.fetch(
      url: '/bookmarks/' + @user.attributes.credential_id
      success: (model, resp) =>
        #console.log(JSON.stringify(@bookmark_collection))
        @bookmark_collection.models.forEach((bookmark)=>
          @$('#mainbox').append(@template_bookmark(bookmark: bookmark.attributes.bookmark, article: bookmark.attributes.article, article_stats: bookmark.attributes.article_stats, user: bookmark.attributes.user))
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
        @bookmark_collection.fetch(
          url: '/bookmarks/' + @user.attributes.credential_id + '/' + @offset
          success: (model, resp) =>
            #console.log('hi')
            #console.log(JSON.stringify(@bookmark_collection))
            @offset = @bookmark_collection.models[0].attributes.offset
            @bookmark_collection.models[0].attributes.bookmark_collection.forEach((bookmark)=>
              @$('#mainbox').append(@template_bookmark(bookmark: bookmark.bookmark, article: bookmark.article, article_stats: bookmark.article_stats, user: bookmark.user))
            )
          error: () =>
            alert('Error fetching my bookmarks!')
        )
      error: =>
    )
    return this

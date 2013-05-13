Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.TopBarView extends Backbone.View
  template: JST["backbone/templates/apps/topbar"]
  
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
        @$('#addBookmarkPopup').hide()
      error: () =>
        alert('Bookmark Save Error!')
    )
    
  getMyBookmarks: (e) ->
    e.stopPropagation()
    e.preventDefault()
    router.navigate("bookmarks/" + appConstants.CURRENTUSER.attributes.credential_id,{trigger : true}) 
  
  toggleBookmarkPopup: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @$('#addBookmarkPopup').toggle()  

  render: ->
    @user.fetch(
      success: (model, resp) =>
        appConstants.CURRENTUSER = this.user
        $(@el).html(@template(user: this.user))
        $("#bookmarkTagsInput", @el).tagsInput()
        $('#addBookmarkPopup', @el).hide()
        console.log(model)
      error: =>
    )
    return this

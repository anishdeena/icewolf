Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.TopBarView extends Backbone.View
  template: JST["backbone/templates/apps/topbar"]
  
  offset = 0
  
  events:
    "click #submitBtn"      : "saveBookmark"
    "click #addBookmarkBtn" : "toggleBookmarkPopup"
    "click #myBookmarksBtn" : "getMyBookmarks"
    "click #logoBtn"        : "gotoHome"
    "keyup #mainSearchBox"  : "searchBookmarks"
    "click #signOut"        : "signOut"
  
  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
    @bookmark_collection = new Icewolf.Collections.BookmarksCollection()
    @cookie = new Cookie()
    @errors = new Errors()
    
  searchBookmarks: (e) ->
    if ((e.keyCode || e.which) == 13) #Enter Key
      router.navigate("search/" + @$('#mainSearchBox').val(), {trigger : true})
    
  gotoHome: (e) ->
    e.stopPropagation()
    e.preventDefault()
    router.navigate("home",{trigger : true})    
    
  saveBookmark: (e) ->
    e.stopPropagation()
    e.preventDefault()
    @$('#popupItemsContainer').hide()
    @$('#popupLoaderContainer').fadeIn()
    @bookmark.save({url: @$('#urlbox').val(), comment: @$('#commentbox').val(), tags: @$('#bookmarkTagsInput').val()}
      success: (model, resp) =>
        @$('#popupLoaderContainer').hide()
        @$('#popupItemsContainer').fadeIn()
        @$('#urlbox').val('')
        @$('#commentbox').val('')
        @$('#addBookmarkPopup').hide()
        @bookmark.clear()
      error: () =>
        @$('#popupLoaderContainer').hide()
        @$('#popupItemsContainer').show()
        @$('#urlbox').val('')
        @$('#commentbox').val('')
        @$('#addBookmarkPopup').hide()
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
    
  signOut: (e) ->
    e.preventDefault()
    e.stopPropagation()
    @isAccountMenuVisible = 0
    @session.fetch(
      success:() =>
        @cookie.expire(appConstants.COOKIE_NAME)
        FB.logout(
          (response) ->
            console.log('Signed out!')
        )
        router.navigate("#",{trigger: true})
    )  

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

Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
  template: JST["backbone/templates/apps/home"]
  
  events:
    "click #submitBtn" : "saveBookmark"
    "click #addBookmarkBtn" : "toggleBookmarkPopup"
  
  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @bookmark = new Icewolf.Models.Bookmark()
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
  
  toggleBookmarkPopup: (e) ->
    e.stopPropagation()
    e.preventDefault()
    $('#addBookmarkPopup').toggle()  

  render: ->
    @user.fetch(
      success: (model, resp) =>
        $(@el).html(@template())
        $("#bookmarkTagsInput", @el).tagsInput()
        $('#addBookmarkPopup', @el).hide()
        console.log(model)
      error: =>
    )
    return this

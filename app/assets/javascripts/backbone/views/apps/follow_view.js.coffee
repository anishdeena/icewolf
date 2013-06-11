Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.FollowView extends Backbone.View
  template: JST["backbone/templates/apps/follow"]
  template_friendItem: JST["backbone/templates/apps/friendItem"]
  
  events:
    "keyup #friendSearchBox" : "searchFriends"
    "click button.followBtn" : "toggleFriendSelection"

  constructor: (options) ->
    super(options)
    @following = []
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @friends = new Icewolf.Collections.FriendsCollection()
    @friends.on('reset', @doOnFriendsCollectionReady, this)
    @cookie = new Cookie()
    @errors = new Errors()
    
  doOnFriendsCollectionReady: () ->
    console.log(@friends)
    that = @
    @friends.models.forEach((friend) =>
      $('#friendsContainer', that.el).append(that.template_friendItem(friend: friend))
    )
    
  searchFriends: (e) ->
    prefix = $(e.target).val()
    prefix = $.trim(prefix)
    $('#friendsContainer', @el).html('')  
    pattern = '/\b' + prefix + '/i'
    searchterm = new RegExp(prefix,'i')
    @friends.models.forEach((friend) =>
      if searchterm.test(friend.attributes.name)
        $('#friendsContainer', @el).append(@template_friendItem(friend: friend))
    )

  toggleFriendSelection: (e) ->
    if $(e.currentTarget).hasClass('btn-success')
      $(e.currentTarget).html('Follow')
      $(e.currentTarget).removeClass('btn-success')
      @following = $.grep(@following, (value) ->
        value != $(e.currentTarget).attr('fbuid')
      )
    else
      $(e.currentTarget).html('Unfollow')
      $(e.currentTarget).addClass('btn-success')
      @following.push($(e.currentTarget).attr('fbuid'))
    console.log(@following)

  render: ->
    @friends.fetch()
    $(@el).html(@template())
    return this

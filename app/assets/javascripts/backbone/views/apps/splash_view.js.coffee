Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.SplashView extends Backbone.View
  template: JST["backbone/templates/apps/splash"]

  events :
    "click #fbConnectBtn"       : "fbconnect"
  
  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @cookie = new Cookie()
    @errors = new Errors()

  fbconnect: () ->
    that = this
    FB.login(
      (response) ->
        if response.authResponse
            #connected
            #alert("signedin!")
            that.signIn(response.authResponse.userID)
        else
            #cancelled
            #alert("cancelled!")
            msg = 'You have cancelled Facebook Login. Kindly login to enter!'
      scope: 'email'
    )
    
  fbconnect_test_stub: () ->
    @signIn('100004133943578')
    
  signIn: (userID) ->
    that = this
    @session.save({fbuid: userID, wait: true},
      success: (model, resp) ->
        that.cookie.create(appConstants.COOKIE_NAME, model.attributes.auth_token)
        router.navigate("home", {trigger: true})
      error: (model, jqXHR) ->
        if that.errors.getCustomErrorCode(jqXHR) == 3001 #CREDENTIAL_NOT_FOUND
          that.fbSync()
    )
    
  fbSync: () ->
    that = this
    FB.api('/me', 
      (response) ->
        #alert('Your name is ' + response.name);
        that.memberDetails = response
    )
    FB.api('/me/friends', 
      (response) ->
        #alert('Friends Obtained!');
        that.friendDetails = response
        that.user.save({me: that.memberDetails, friends: that.friendDetails, wait:true},
          success: (model, resp) =>
            document.cookie = appConstants.COOKIE_NAME + "=" + model.attributes.auth_token
            router.navigate("home", {trigger: true})
          error: (model, jqXHR) =>
            #if that.errors.getCustomErrorCode(jqXHR) == 2000
              #msg = 'This Facebook account has already been linked to Frilp. Please use a different account!'
        )
    )

  render: ->
    $(@el).html(@template())
    return this

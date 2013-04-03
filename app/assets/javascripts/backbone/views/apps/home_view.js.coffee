Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
  template: JST["backbone/templates/apps/home"]

  constructor: (options) ->
    super(options)
    @session = new Icewolf.Models.Session()
    @user = new Icewolf.Models.User()
    @cookie = new Cookie()
    @errors = new Errors()

  render: ->
    @user.fetch(
      success: (model, resp) =>
        $(@el).html(@template())
        console.log(model)
      error: =>
    )
    $(@el).html(@template())
    return this

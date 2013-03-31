Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.SplashView extends Backbone.View
  template: JST["backbone/templates/apps/splash"]

  render: ->
    $(@el).html(@template())
    return this

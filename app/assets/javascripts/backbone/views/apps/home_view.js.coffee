Icewolf.Views.Apps ||= {}

class Icewolf.Views.Apps.HomeView extends Backbone.View
  template: JST["backbone/templates/apps/home"]

  render: ->
    $(@el).html(@template())
    return this

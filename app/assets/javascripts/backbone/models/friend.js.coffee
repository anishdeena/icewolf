class Icewolf.Models.Friend extends Backbone.Model
  paramRoot: 'friend'

  urlRoot: '/friend'

class Icewolf.Collections.FriendsCollection extends Backbone.Collection
  model: Icewolf.Models.Friend
  url: '/friends'

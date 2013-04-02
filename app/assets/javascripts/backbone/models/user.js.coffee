class Icewolf.Models.User extends Backbone.Model
  paramRoot: 'user'
  urlRoot: '/me'

class Icewolf.Collections.UsersCollection extends Backbone.Collection
  model: Icewolf.Models.User
  url: '/users'

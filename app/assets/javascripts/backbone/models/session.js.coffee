class Icewolf.Models.Session extends Backbone.Model
  paramRoot: 'session'
  
  urlRoot: '/session'

class Icewolf.Collections.SessionsCollection extends Backbone.Collection
  model: Icewolf.Models.Session
  url: '/sessions'

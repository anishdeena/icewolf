class Icewolf.Models.Article extends Backbone.Model
  paramRoot: 'article'

  urlRoot: '/article'

class Icewolf.Collections.ArticlesCollection extends Backbone.Collection
  model: Icewolf.Models.Article
  url: '/articles'

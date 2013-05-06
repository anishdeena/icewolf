class Icewolf.Models.Bookmark extends Backbone.Model
  paramRoot: 'bookmark'
  
  urlRoot: '/bookmark'

class Icewolf.Collections.BookmarksCollection extends Backbone.Collection
  model: Icewolf.Models.Bookmark
  url: '/bookmarks'

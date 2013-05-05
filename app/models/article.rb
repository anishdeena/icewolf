class Article < ActiveRecord::Base
  attr_accessible :deleted, :description, :image_url, :title, :url, :tags
  
  has_many :bookmarks
  has_many :article_stats
end

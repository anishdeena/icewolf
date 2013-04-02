class Article < ActiveRecord::Base
  attr_accessible :credential_id, :deleted, :description, :image_url, :title, :url
  
  belongs_to :credential
end

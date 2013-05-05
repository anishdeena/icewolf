class Bookmark < ActiveRecord::Base
  attr_accessible :article_id, :comment, :credential_id, :tags
  
  belongs_to :article
  belongs_to :credential
end

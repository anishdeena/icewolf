class ArticleStats < ActiveRecord::Base
  attr_accessible :article_id, :count_bookmark, :downvote, :upvote, :count_view, :count_comment
  
  belongs_to :article
end

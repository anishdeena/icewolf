class CreateArticleStats < ActiveRecord::Migration
  def change
    create_table :article_stats do |t|
      t.integer :article_id
      t.integer :count_bookmark, :default => 0
      t.integer :upvote, :default => 0
      t.integer :downvote, :default => 0
      t.integer :count_view, :default => 0
      t.integer :count_comment, :default => 0

      t.timestamps
    end
  end
end

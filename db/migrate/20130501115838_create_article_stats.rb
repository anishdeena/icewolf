class CreateArticleStats < ActiveRecord::Migration
  def change
    create_table :article_stats do |t|
      t.integer :article_id
      t.integer :count_bookmark
      t.integer :upvote
      t.integer :downvote
      t.integer :count_view
      t.integer :count_comment

      t.timestamps
    end
  end
end

class CreateBookmarks < ActiveRecord::Migration
  def change
    create_table :bookmarks do |t|
      t.integer :credential_id
      t.integer :article_id
      t.text :comment
      t.text :tags

      t.timestamps
    end
  end
end

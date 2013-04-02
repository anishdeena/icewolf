class CreateArticles < ActiveRecord::Migration
  def change
    create_table :articles do |t|
      t.text :title
      t.text :description
      t.text :url
      t.text :image_url
      t.boolean :deleted
      t.integer :credential_id

      t.timestamps
    end
  end
end

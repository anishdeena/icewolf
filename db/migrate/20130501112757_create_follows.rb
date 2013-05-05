class CreateFollows < ActiveRecord::Migration
  def change
    create_table :follows do |t|
      t.integer :follower
      t.integer :followee

      t.timestamps
    end
  end
end

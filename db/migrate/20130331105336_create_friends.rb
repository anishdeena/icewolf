class CreateFriends < ActiveRecord::Migration
  def change
    create_table :friends do |t|
      t.string :name
      t.integer :provider_type
      t.integer :credential_id
      t.string :unique_id

      t.timestamps
    end
  end
end

class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :firstname
      t.string :lastname
      t.string :gender
      t.integer :credential_id
      t.integer :age
      t.string :avatar_url

      t.timestamps
    end
  end
end

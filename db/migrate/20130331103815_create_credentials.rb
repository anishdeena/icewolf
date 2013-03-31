class CreateCredentials < ActiveRecord::Migration
  def change
    create_table :credentials do |t|
      t.string :email
      t.string :password
      t.string :salt
      t.integer :account_type
      t.boolean :deleted
      t.string :fbuid

      t.timestamps
    end
  end
end

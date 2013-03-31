class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :auth_token
      t.integer :credential_id
      t.integer :session_type
      t.datetime :last_accessed_at
      t.boolean :expired

      t.timestamps
    end
  end
end

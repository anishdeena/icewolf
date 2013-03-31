class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.integer :provider_type
      t.string :unique_id
      t.integer :credential_id

      t.timestamps
    end
  end
end

class CreateAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :auths do |t|
      t.integer :user_id, null: false
      t.string :token, null: false

      t.timestamps
    end
    add_index :auths, [:user_id, :token], :unique => true
  end
end

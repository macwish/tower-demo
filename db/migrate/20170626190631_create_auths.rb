class CreateAuths < ActiveRecord::Migration[5.1]
  def change
    create_table :auths do |t|
      t.integer :user_id, null: false
      t.string :token, null: false

      t.timestamps
    end
  end
end

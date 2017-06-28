class CreateProjectMembers < ActiveRecord::Migration[5.1]
  def change
    create_table :project_members do |t|
      t.integer :project_id, null: false
      t.integer :user_id, null: false

      t.timestamps
    end
    add_index :project_members, :project_id
    add_index :project_members, :user_id
    add_index :project_members, [:project_id, :user_id], :unique => true
  end
end

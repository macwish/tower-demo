class CreateProjectMemberRoles < ActiveRecord::Migration[5.1]
  def change
    create_table :project_member_roles do |t|
      t.integer :member_id, null: false
      t.integer :type, null: false

      t.timestamps
    end
    add_index :project_member_roles, :member_id
  end
end

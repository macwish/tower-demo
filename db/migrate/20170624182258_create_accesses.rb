class CreateAccesses < ActiveRecord::Migration[5.1]
  def change
    create_table :accesses do |t|

      # role-based ACL
      
      t.string :scope, null: false
      # t.integer :project_member_role_id, null: false
      t.integer :permission, null: false

      t.integer :accessrelated_id
      t.string :accessrelated_type

      t.timestamps
    end
    add_index :accesses, :scope
    # add_index :accesses, :project_member_role_id
  end
end

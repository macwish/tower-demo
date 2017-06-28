class CreateProjectTodos < ActiveRecord::Migration[5.1]
  def change
    create_table :project_todos do |t|
      t.integer :todo_list_id, null: false
      t.text :content, null: false
      t.integer :assignd_to_member_id
      t.integer :deadline
      t.boolean :completed, null: false
      t.boolean :trashed, null: false
      
      t.timestamps
    end
    add_index :project_todos, [:todo_list_id, :trashed]
    add_index :project_todos, :completed
    add_index :project_todos, :trashed
  end
end

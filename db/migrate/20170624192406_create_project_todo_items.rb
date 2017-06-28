class CreateProjectTodoItems < ActiveRecord::Migration[5.1]
  def change
    create_table :project_todo_items do |t|
      t.integer :todo_id, null: false
      t.string :description, null: false
      t.boolean :completed, null: false

      t.timestamps
    end
    add_index :project_todo_items, [:todo_id, :completed]
  end
end

class CreateProjectTodoLists < ActiveRecord::Migration[5.1]
  def change
    create_table :project_todo_lists do |t|
      t.integer :project_id, null: false
      t.string :name, null: false
      t.string :description
      t.boolean :trashed, null: false

      t.timestamps
    end
  end
end

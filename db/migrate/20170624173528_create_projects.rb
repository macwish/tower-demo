class CreateProjects < ActiveRecord::Migration[5.1]
  def change
    create_table :projects do |t|
      t.integer :team_id, null: false
      t.string :name, null: false
      t.string :description
      t.integer :type, null: false
      t.boolean :is_private, null: false
      t.integer :status, null: false
      t.boolean :pinned
      t.integer :icon
      t.integer :color
      t.integer :start_time
      t.integer :end_time
      t.boolean :archived, null: false
      t.boolean :removed, null: false

      t.timestamps
    end
    add_index :projects, :team_id
  end
end

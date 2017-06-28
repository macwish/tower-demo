class CreateTeams < ActiveRecord::Migration[5.1]
  def change
    create_table :teams do |t|
      t.string :name, null: false
      t.integer :creator_id, null: false
      t.integer :admin_id, null: false
      t.boolean :removed, null: false

      t.timestamps
    end
    add_index :teams, :name
  end
end

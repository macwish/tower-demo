class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.integer :type, null: false

      t.integer :user_id, null: false   # who
      t.integer :action, null: false    # did what
      t.text :target, null: false       # to whom
      t.integer :time, null: false      # at when

      t.text :info                      # extra info (null able, hash able)

      # event-related: specify which model may have event (Todo, Comment, ...)
      t.integer :eventrelated_id
      t.string :eventrelated_type

      # orogin-related: in general, it's model 'Project' or 'Weeky_Reporting'
      t.integer :originrelated_id
      t.string :originrelated_type

      t.timestamps
    end
  end
end

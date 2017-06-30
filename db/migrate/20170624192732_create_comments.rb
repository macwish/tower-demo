class CreateComments < ActiveRecord::Migration[5.1]
  def change
    create_table :comments do |t|
      t.text :content, null: false
      t.integer :user_id, null: false
      t.integer :status, null: false  # 0: normal, -1: forbidden

      t.integer :commentable_id
      t.string :commentable_type

      t.timestamps
    end
    add_index :comments, :user_id
  end
end

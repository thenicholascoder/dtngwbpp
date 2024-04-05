class CreateDislikes < ActiveRecord::Migration[7.1]
  def change
    create_table :dislikes do |t|
      t.references :disliker, null: false, foreign_key: { to_table: :users }
      t.references :disliked, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end
    add_index :dislikes, [:disliker_id, :disliked_id], unique: true
  end
end

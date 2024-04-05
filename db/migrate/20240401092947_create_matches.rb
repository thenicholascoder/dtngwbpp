class CreateMatches < ActiveRecord::Migration[7.1]
  def change
    create_table :matches do |t|
      t.integer :user_1
      t.integer :user_2
      t.timestamps
    end
    add_index :matches, [:user_1, :user_2], unique: true
  end
end

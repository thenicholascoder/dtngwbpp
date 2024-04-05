class CreateMessages < ActiveRecord::Migration[7.1]
  def change
    create_table :messages do |t|
      t.integer :sender_id
      t.integer :recipient_id
      t.string :body
      t.boolean :seen, default: false
      t.timestamps
    end
  end
end

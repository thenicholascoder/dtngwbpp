class CreateUserPhotos < ActiveRecord::Migration[7.1]
  def change
    create_table :user_photos do |t|
      t.references :user, foreign_key: { on_delete: :cascade }
      t.references :photo, foreign_key: { on_delete: :cascade }
      t.timestamps
    end
  end
end

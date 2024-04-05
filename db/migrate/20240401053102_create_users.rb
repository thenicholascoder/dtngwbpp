class CreateUsers < ActiveRecord::Migration[7.1]
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :mobile
      t.string :email
      t.date :birthdate
      t.string :gender
      t.string :sexual_orientation
      t.string :gender_interest
      t.string :country
      t.string :state
      t.string :city
      t.string :school
      t.string :bio
      t.boolean :is_admin, default: false
      t.string :password_digest
      t.string :remember_digest

      t.timestamps
    end
    add_index :users, :email, unique: true
  end
end

class CreateUsers < ActiveRecord::Migration[6.0]
  def change
    create_table :users do |t|
      t.string :username
      t.string :password_digest
      t.string :bio
      t.string :address
      t.float :latitude
      t.float :longitude
      t.string :email

      t.timestamps
    end
  end
end

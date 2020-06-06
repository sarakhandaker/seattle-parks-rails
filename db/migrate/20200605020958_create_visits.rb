class CreateVisits < ActiveRecord::Migration[6.0]
  def change
    create_table :visits do |t|
      t.datetime :date
      t.integer :user_id
      t.integer :park_id
      t.integer :rating
      t.string :comment
      t.string :photo
      t.boolean :completed

      t.timestamps
    end
  end
end

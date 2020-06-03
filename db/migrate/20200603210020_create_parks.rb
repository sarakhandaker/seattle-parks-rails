class CreateParks < ActiveRecord::Migration[6.0]
  def change
    create_table :parks do |t|
      t.string :name
      t.string :address
      t.float :latitude
      t.float :longitude
      t.integer :area

      t.timestamps
    end
  end
end

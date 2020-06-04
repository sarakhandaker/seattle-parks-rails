class CreateParkFeatures < ActiveRecord::Migration[6.0]
  def change
    create_table :park_features do |t|
      t.integer :park_id
      t.integer :feature_id
      t.string :hours

      t.timestamps
    end
  end
end

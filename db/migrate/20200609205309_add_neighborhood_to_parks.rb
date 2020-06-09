class AddNeighborhoodToParks < ActiveRecord::Migration[6.0]
  def change
    add_column :parks, :neighborhood, :string
  end
end

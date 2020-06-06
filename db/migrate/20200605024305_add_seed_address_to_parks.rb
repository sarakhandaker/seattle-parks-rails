class AddSeedAddressToParks < ActiveRecord::Migration[6.0]
  def change
    add_column :parks, :seedAddress, :string
  end
end

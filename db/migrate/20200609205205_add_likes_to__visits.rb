class AddLikesToVisits < ActiveRecord::Migration[6.0]
  def change
    add_column :visits, :likes, :integer
  end
end

class AddColumnsToRestaurantsSecond < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :opentime, :string
    add_column :restaurants, :holiday, :string
    add_column :restaurants, :combined_access, :string
    add_column :restaurants, :line, :string
    add_column :restaurants, :station, :string
    add_column :restaurants, :station_exit, :string
    add_column :restaurants, :walk, :integer
  end
end

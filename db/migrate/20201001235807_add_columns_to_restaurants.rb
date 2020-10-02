class AddColumnsToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :name, :string
    add_column :restaurants, :category, :string
    add_column :restaurants, :place, :string
    add_column :restaurants, :recommended_menu, :string
  end
end

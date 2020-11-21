class AddImageToArchivedRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :archived_restaurants, :image, :string
  end
end

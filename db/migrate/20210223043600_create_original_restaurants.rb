class CreateOriginalRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :original_restaurants do |t|
      t.integer :price
      t.text :url
      t.string :name
      t.string :category
      t.string :place
      t.string :tel
      t.string :opentime
      t.string :holiday
      t.string :combined_access
      t.string :line
      t.string :station
      t.string :station_exit
      t.integer :walk
      t.string :image

      t.timestamps
    end
  end
end

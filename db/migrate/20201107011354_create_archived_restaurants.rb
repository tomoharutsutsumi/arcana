class CreateArchivedRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :archived_restaurants do |t|
      t.references :archived_list, foreign_key: true
      t.integer :price
      t.text :comment
      t.text :url
      t.string :participant
      t.string :name
      t.string :category
      t.string :place
      t.string :recommended_menu
      t.string :tel
      t.string :opentime
      t.string :holiday
      t.string :combined_access
      t.string :line
      t.string :station
      t.string :station_exit
      t.integer :walk

      t.timestamps
    end
  end
end

class CreateRestaurants < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurants do |t|
      t.references :list, foreign_key: true
      t.integer :price
      t.text :comment
      t.text :url

      t.timestamps
    end
  end
end

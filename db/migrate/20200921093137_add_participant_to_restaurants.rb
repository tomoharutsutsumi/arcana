class AddParticipantToRestaurants < ActiveRecord::Migration[5.2]
  def change
    add_column :restaurants, :participant, :string
  end
end

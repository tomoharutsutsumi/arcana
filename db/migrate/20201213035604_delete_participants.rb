class DeleteParticipants < ActiveRecord::Migration[5.2]
  def change
    drop_table :participants
  end
end

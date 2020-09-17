class CreatePermissionRequests < ActiveRecord::Migration[5.2]
  def change
    create_table :permission_requests do |t|
      t.integer :sent_from_id
      t.integer :sent_to_id

      t.timestamps
    end

    add_index :permission_requests, :sent_from_id
    add_index :permission_requests, :sent_to_id
    add_index :permission_requests, [:sent_from_id, :sent_to_id], unique: true
  end
end

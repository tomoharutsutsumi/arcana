class CreatePermissionLists < ActiveRecord::Migration[5.2]
  def change
    create_table :permission_lists do |t|
      t.references :list, foreign_key: true
      t.references :permission_request, foreign_key: true

      t.timestamps
    end
    add_index :permission_lists, [:list_id, :permission_request_id], unique: true
  end
end

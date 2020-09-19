class AddStatusToPermissionRequest < ActiveRecord::Migration[5.2]
  def change
    add_column :permission_requests, :status, :integer
  end
end

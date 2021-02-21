class AddNullFalse < ActiveRecord::Migration[5.2]
  def change
    ArchivedList.all.find_each do |l|
      if l.user_id == null
        l.update(user_id: 1)
      end
    end
    change_column_null :archived_lists, :user_id, false
    change_column_null :archived_restaurants, :archived_list_id, false
    change_column_null :archivings, :user_id, false
    change_column_null :archivings, :archived_list_id, false
    change_column_null :lists, :user_id, false
    change_column_null :permission_lists, :list_id, false
    change_column_null :permission_lists, :permission_request_id, false
    change_column_null :permission_requests, :sent_from_id, false
    change_column_null :permission_requests, :sent_to_id, false
    change_column_null :restaurants, :list_id, false
  end
end

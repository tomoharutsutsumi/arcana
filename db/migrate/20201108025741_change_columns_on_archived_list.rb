class ChangeColumnsOnArchivedList < ActiveRecord::Migration[5.2]
  def change
    add_column :archived_lists, :original_user_name, :string
    remove_column :archived_lists, :user_id, :bigint
  end
end

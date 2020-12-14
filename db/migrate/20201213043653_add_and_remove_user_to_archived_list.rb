class AddAndRemoveUserToArchivedList < ActiveRecord::Migration[5.2]
  def change
    add_reference :archived_lists, :user, foreign_key: true

    ArchivedList.find_each do |l|
      l.update(user_id: User.find_by(name: l.original_user_name)&.id)
    end

    remove_column :archived_lists, :original_user_name, :string
  end
end

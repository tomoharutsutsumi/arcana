class ArchivedList < ApplicationRecord
  has_many :archivings
  has_many :users, through: :archivings
  has_many :archived_restaurants

  def self.archive(list)
    archived_list = ArchivedList.create(title: list.title, original_user_name: list.user.name)
    list.permission_requests.each do |r|
      user = User.find(r.sent_from_id)
      user.archivings.create(archived_list_id: archived_list.id)
    end
    ArchivedRestaurant.archive(archived_list, list)
  end
end

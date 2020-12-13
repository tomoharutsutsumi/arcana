class ArchivedList < ApplicationRecord
  has_many :archivings
  has_many :users, through: :archivings
  has_many :archived_restaurants
  belongs_to :user

  def self.archive(list)
    archived_list = ArchivedList.create(title: list.title, user: list.user)
    list.permission_requests.each do |r|
      user = User.find(r.sent_from_id)
      user.archivings.create(archived_list_id: archived_list.id)
    end
    ArchivedRestaurant.archive(archived_list, list)
  end
end

class ArchivedList < ApplicationRecord
  belongs_to :user
  has_many :archived_restaurants

  def self.archive(list, user)
    archived_list = user.archived_lists.create(title: list.title)
    ArchivedRestaurant.archive(archived_list, list)
  end
end

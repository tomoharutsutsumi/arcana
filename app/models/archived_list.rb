class ArchivedList < ApplicationRecord
  belongs_to :user
  has_many :archived_restaurants
end

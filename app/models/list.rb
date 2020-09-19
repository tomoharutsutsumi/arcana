class List < ApplicationRecord
  belongs_to :user
  has_many :permission_lists
  has_many :permission_requests, through: :permission_lists

  validates :title, presence: true
end

class List < ApplicationRecord
  belongs_to :user
  has_many :permission_lists, dependent: :destroy
  has_many :permission_requests, through: :permission_lists
  has_many :restaurants, dependent: :destroy

  validates :title, presence: true
end

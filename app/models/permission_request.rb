class PermissionRequest < ApplicationRecord
  DEFAULT = 10
  PERMITTED = 20
  REJECTED = 30

  has_many :permission_lists
  has_many :lists, through: :permission_lists
  belongs_to :sent_from, class_name: 'User'
  belongs_to :sent_to, class_name: 'User'
end

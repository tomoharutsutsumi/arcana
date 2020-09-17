class PermissionRequest < ApplicationRecord
  belongs_to :sent_from, class_name: 'User'
  belongs_to :sent_to, class_name: 'User'
end

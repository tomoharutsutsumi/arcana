class PermissionList < ApplicationRecord
  belongs_to :list
  belongs_to :permission_request
end

class Archiving < ApplicationRecord
  belongs_to :user
  belongs_to :archived_list
end

class Restaurant < ApplicationRecord
  belongs_to :list
  has_many :participants
end

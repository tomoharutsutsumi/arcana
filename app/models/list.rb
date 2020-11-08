class List < ApplicationRecord
  belongs_to :user
  has_many :permission_lists, dependent: :destroy
  has_many :permission_requests, through: :permission_lists
  has_many :restaurants, dependent: :destroy

  validates :title, presence: true

  def archive_and_destroy
    transaction do
      archive
      destroy
    end
  end

  def archive
    user = User.find(permission_requests.sent_from_id)
    ArchivedList.archive(user, self)
  end
end

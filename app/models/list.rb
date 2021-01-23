class List < ApplicationRecord
  belongs_to :user
  has_many :permission_lists, dependent: :destroy
  has_many :permission_requests, through: :permission_lists
  has_many :restaurants, dependent: :destroy

  validates :title, presence: true

  before_save :attach_share_hash

  def archive_and_destroy
    transaction do
      archive
      destroy
    end
  end

  def archive
    ArchivedList.archive(self) 
  end

  def attach_share_hash
    self.assign_attributes(share_hash: Digest::SHA1.hexdigest(Time.now.to_s))
  end
end

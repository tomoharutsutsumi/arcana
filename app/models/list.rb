class List < ApplicationRecord
  belongs_to :user
  has_many :permission_lists, dependent: :destroy
  has_many :permission_requests, through: :permission_lists
  has_many :restaurants, dependent: :destroy

  validates :title, presence: true

  before_create :attach_share_hash

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
    self.assign_attributes(share_hash: Digest::SHA1.hexdigest(Time.now.to_s + Random.rand(100).to_s))
  end
end

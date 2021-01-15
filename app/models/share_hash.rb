class ShareHash < ApplicationRecord
  belongs_to :list

  before_create :create_hash

  private

  def create_hash
    self.assign_attributes(hash_string: Digest::SHA1.hexdigest(Time.now.to_s))
  end
end

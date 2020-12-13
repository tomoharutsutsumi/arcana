class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :omniauthable

  has_many :active_permission_requests, class_name: 'PermissionRequest', 
                                        foreign_key: 'sent_from_id', 
                                        dependent: :destroy
  has_many :sent_to_users, through: :active_permission_requests, source: :sent_to
  has_many :passive_permission_requests, class_name: 'PermissionRequest', 
                                         foreign_key: 'sent_to_id', 
                                         dependent: :destroy
  has_many :sent_from_users, through: :passive_permission_requests, source: :sent_from
  has_many :lists
  has_many :archivings
  has_many :archived_lists, through: :archivings
  has_many :archiving_lists, class_name: 'ArchivedList'

  validates :name, presence: true

  def self.from_omniauth(auth)
    where(provider: auth.provider, uid: auth.uid).first_or_create! do |user|
      user.provider = auth.provider
      user.uid = auth.uid
      user.name = auth.info.name
      user.email = auth.info.email
      user.password = Devise.friendly_token[0, 20]
    end
  end
end

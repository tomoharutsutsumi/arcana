class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :active_permission_requests, class_name: 'PermissionRequest', 
                                        foreign_key: 'sent_from_id', 
                                        dependent: :destroy
  has_many :sent_to_users, through: :active_permission_requests, source: :sent_to
  has_many :passive_permission_requests, class_name: 'PermissionRequest', 
                                         foreign_key: 'sent_to_id', 
                                         dependent: :destroy
  has_many :sent_from_users, through: :passive_permission_requests, source: :sent_from
end

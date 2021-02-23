require "administrate/base_dashboard"

class UserDashboard < Administrate::BaseDashboard
  # ATTRIBUTE_TYPES
  # a hash that describes the type of each of the model's fields.
  #
  # Each different type represents an Administrate::Field object,
  # which determines how the attribute is displayed
  # on pages throughout the dashboard.
  ATTRIBUTE_TYPES = {
    active_permission_requests: Field::HasMany.with_options(class_name: "PermissionRequest"),
    sent_to_users: Field::HasMany.with_options(class_name: "User"),
    passive_permission_requests: Field::HasMany.with_options(class_name: "PermissionRequest"),
    sent_from_users: Field::HasMany.with_options(class_name: "User"),
    lists: Field::HasMany,
    archivings: Field::HasMany,
    archived_lists: Field::HasMany,
    archiving_lists: Field::HasMany.with_options(class_name: "ArchivedList"),
    id: Field::Number,
    email: Field::String,
    encrypted_password: Field::String,
    name: Field::String,
    reset_password_token: Field::String,
    reset_password_sent_at: Field::DateTime,
    remember_created_at: Field::DateTime,
    created_at: Field::DateTime,
    updated_at: Field::DateTime,
    uid: Field::String,
    provider: Field::String,
    nickname: Field::String,
  }.freeze

  # COLLECTION_ATTRIBUTES
  # an array of attributes that will be displayed on the model's index page.
  #
  # By default, it's limited to four items to reduce clutter on index pages.
  # Feel free to add, remove, or rearrange items.
  COLLECTION_ATTRIBUTES = %i[
  active_permission_requests
  sent_to_users
  passive_permission_requests
  sent_from_users
  ].freeze

  # SHOW_PAGE_ATTRIBUTES
  # an array of attributes that will be displayed on the model's show page.
  SHOW_PAGE_ATTRIBUTES = %i[
  active_permission_requests
  sent_to_users
  passive_permission_requests
  sent_from_users
  lists
  archivings
  archived_lists
  archiving_lists
  id
  email
  encrypted_password
  name
  reset_password_token
  reset_password_sent_at
  remember_created_at
  created_at
  updated_at
  uid
  provider
  nickname
  ].freeze

  # FORM_ATTRIBUTES
  # an array of attributes that will be displayed
  # on the model's form (`new` and `edit`) pages.
  FORM_ATTRIBUTES = %i[
  active_permission_requests
  sent_to_users
  passive_permission_requests
  sent_from_users
  lists
  archivings
  archived_lists
  archiving_lists
  email
  encrypted_password
  name
  reset_password_token
  reset_password_sent_at
  remember_created_at
  uid
  provider
  nickname
  ].freeze

  # COLLECTION_FILTERS
  # a hash that defines filters that can be used while searching via the search
  # field of the dashboard.
  #
  # For example to add an option to search for open resources by typing "open:"
  # in the search field:
  #
  #   COLLECTION_FILTERS = {
  #     open: ->(resources) { resources.where(open: true) }
  #   }.freeze
  COLLECTION_FILTERS = {}.freeze

  # Overwrite this method to customize how users are displayed
  # across all pages of the admin dashboard.
  #
  # def display_resource(user)
  #   "User ##{user.id}"
  # end
end

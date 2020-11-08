class Users::PermissionLists::PermittedListsController < ApplicationController
  def index
    @permitted_lists = List.includes(:permission_requests)
                           .where(permission_requests: {sent_from_id: current_user.id, status: PermissionRequest::PERMITTED})
    @permitted_lists = current_user.archived_lists + @pemitted_lists if current_user.archived_lists.present?
  end
end
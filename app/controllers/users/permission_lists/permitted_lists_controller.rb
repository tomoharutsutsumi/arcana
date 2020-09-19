class Users::PermissionLists::PermittedListsController < ApplicationController
  def index
    @permitted_lists = List.includes(:permission_requests)
                           .where(permission_requests: {sent_from_id: current_user.id, status: PermissionRequest::PERMITTED})
  end
end
class Users::PermissionLists::PermittedListsController < ApplicationController
  def index
    @permitted_lists = List.includes(:permission_requests)
                           .where(permission_requests: {sent_from_id: current_user.id, status: PermissionRequest::PERMITTED})
    if @permitted_lists.present? && current_user.archived_lists.present?
      @permitted_lists = current_user.archived_lists + @permitted_lists
    elsif @permitted_lists.present?
      @permitted_lists
    elsif current_user.archived_lists.present?
      @permitted_lists = current_user.archived_lists
    end
  end
end
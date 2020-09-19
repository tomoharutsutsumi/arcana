class Users::PermissionListsController < ApplicationController
  def index
    @lists = current_user.lists
    @permission_request_id = params[:permission_request_id]
  end

  def create
    PermissionList.create!(list_id: params[:list_id], permission_request_id: params[:permission_request_id])
    redirect_to user_requests_path(current_user)
  end

  def show
  end
end
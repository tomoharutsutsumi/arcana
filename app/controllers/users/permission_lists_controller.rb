class Users::PermissionListsController < ApplicationController
  def index
    @lists = current_user.lists
    @permission_request_id = params[:permission_request_id]
  end

  def create
    params[:list_ids].each do |id|
      PermissionList.create!(list_id: id, permission_request_id: params[:permission_request_id])
    end
    redirect_to users_searches_path
  end

  def show
  end
end
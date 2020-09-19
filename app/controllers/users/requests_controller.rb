class Users::RequestsController < ApplicationController
  before_action :set_user, only: %i(index new create)

  def index
    # 送った人一覧と送られて人一覧でparameterで分けて表示でいいような気がする　今は
    @sent_from_users = current_user.sent_from_users
  end

  def new; end

  def create
    PermissionRequest.create!(sent_from_id: current_user.id, sent_to_id: @user.id, status: PermissionRequest::DEFAULT)
    redirect_to users_searches_path
  end

  def update
    permission_request = PermissionRequest.find_by(sent_from_id: params[:user_id], sent_to_id: current_user.id)
    if params[:judge] == 'permit'
      permission_request.update(status: PermissionRequest::PERMITTED)
      redirect_to user_permission_lists_path(current_user, permission_request_id: permission_request.id)
    elsif params[:judge] == 'reject'
      permission_request.update(status: PermissionRequest::REJECTED)
      user_requests_path(current_user)
    end
  end

  private 

  def set_user
    @user = User.find(params[:user_id])
  end
end
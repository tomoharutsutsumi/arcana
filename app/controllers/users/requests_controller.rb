class Users::RequestsController < ApplicationController
  before_action :set_user, only: %i(index new create)

  def index
    # 送った人一覧と送られて人一覧でparameterで分けて表示でいいような気がする　今は
    @sent_from_users = current_user.sent_from_users
  end

  def new; end

  def create
    PermissionRequest.create!(sent_from_id: current_user.id, sent_to_id: @user.id)
    redirect_to users_searches_path
  end

  def update
    #ショウニン
  end

  def destroy
    # 非承認
  end

  private 

  def set_user
    @user = User.find(params[:user_id])
  end
end
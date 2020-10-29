class Users::ListsController < ApplicationController
  
  def index
    @lists = current_user.lists
  end

  def new
    @list = current_user.lists.build
  end

  def create
    @list = current_user.lists.build(list_params)
    @list.save
    redirect_to user_lists_path(current_user)
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
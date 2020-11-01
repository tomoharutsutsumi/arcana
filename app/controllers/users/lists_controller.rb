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
    redirect_to user_lists_path(current_user), notice: 'リストを登録しました'
  end

  def edit
    @list = List.find(params[:id])
  end

  def update
    @list = List.find(params[:id])
    @list.update(list_params)
    redirect_to user_lists_path(current_user), notice: 'リストを編集しました'
  end

  def destroy
    list = List.find(params[:id])
    list.destroy
    redirect_to user_lists_path(current_user), notice: 'リストを削除しました'
  end

  private

  def list_params
    params.require(:list).permit(:title)
  end
end
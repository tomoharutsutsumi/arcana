class Requests::SharedListsController < ApplicationController
  include RegisterWithSharedList

  def create
    session[:share_hash] = params[:share_hash] if params.has_key?(:share_hash)
    register_with_shared_list(current_user)
    redirect_to user_permitted_lists_path(current_user)
  end
end
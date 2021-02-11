class Requests::SharedListsController < ApplicationController
  include RegisterWithSharedList

  def create
    register_with_shared_list(current_user)
    redirect_to user_permitted_lists_path(current_user)
  end
end
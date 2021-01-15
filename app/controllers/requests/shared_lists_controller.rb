# class Requests::SharedListsController < ApplicationController
#   def create
#     list = ShareHash.find_by(hash_string: session[:hash_string]).list
#     request = PermissionRequest.create(sent_from_id: current_user.id, sent_to_id: list.user.id,  status: PermissionRequest::PERMITTED)
#     PermissionList.create(list: list, permission_request: request)
#     redirect_to user_permitted_lists_path(current_user)
#   end
# end
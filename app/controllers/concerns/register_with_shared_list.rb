module RegisterWithSharedList
  extend ActiveSupport::Concern

  def register_with_shared_list(user)
    if session[:hash_string].present?
      list = ShareHash.find_by(hash_string: session[:hash_string]).list
      request = PermissionRequest.create(sent_from_id: user.id, sent_to_id: list.user.id, status: PermissionRequest::PERMITTED)
      PermissionList.create(list: list, permission_request: request)
      session[:hash_string].clear
    end
  end
end
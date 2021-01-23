module RegisterWithSharedList
  extend ActiveSupport::Concern

  def register_with_shared_list(user)
    if session[:share_hash].present?
      list = List.find_by(share_hash: session[:share_hash])
      request = PermissionRequest.create(sent_from_id: user.id, sent_to_id: list.user.id, status: PermissionRequest::PERMITTED)
      PermissionList.create(list: list, permission_request: request)
      session[:share_hash].clear
    end
  end
end
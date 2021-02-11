module RegisterWithSharedList
  extend ActiveSupport::Concern

  def register_with_shared_list(user)
    if session[:share_hash].present?
      list = List.find_by(share_hash: session[:share_hash])
      request = PermissionRequest.find_by(sent_from_id: user.id, sent_to_id: list.user.id)
      register(list, request, user)
      session[:share_hash].clear
    end
  end

  private

  def register(list, request, user)
    if request.present?
      begin 
        flash[:notice] = 'リストに登録しました'
        PermissionList.create(list: list, permission_request: request)
      rescue
        flash[:alert] = 'すでにリスト一覧に登録されています'
        root_path and return
      end
    else 
      flash[:notice] = 'リストに登録しました'
      new_request = PermissionRequest.create(sent_from_id: user.id, sent_to_id: list.user.id, status: PermissionRequest::PERMITTED)
      PermissionList.create(list: list, permission_request: new_request)
    end
  end
end
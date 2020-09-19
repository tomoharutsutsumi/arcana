module RequestHelper
  def find_request_id(sent_from_id, sent_to_id)
    PermissionRequest.find_by(sent_from_id: sent_from_id, sent_to_id: sent_to_id).id
  end

  def check_requesting_user_status(current_user, requesting_user)
    status = PermissionRequest.find_by(sent_from_id: requesting_user.id, sent_to_id: current_user.id).status
    if status == PermissionRequest::DEFAULT
      link_to '承認', user_request_path(u.id, find_request_id(u.id, current_user.id), judge: 'permit'), method: :patch
      link_to '非承認', user_request_path(u.id, find_request_id(u.id, current_user.id), judge: 'reject'), method: :patch
    elsif status == PermissionRequest::PERMITTED
      '承認済み'
    else
      '非承認'
    end
  end
end
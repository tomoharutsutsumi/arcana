module RequestHelper
  def find_request(sent_from_id, sent_to_id)
    PermissionRequest.find_by(sent_from_id: sent_from_id, sent_to_id: sent_to_id)
  end

  def check_requesting_user_status(current_user, requesting_user)
    status = PermissionRequest.find_by(sent_from_id: requesting_user.id, sent_to_id: current_user.id).status
    if status == PermissionRequest::DEFAULT
      link_to('承認', user_request_path(requesting_user.id, find_request(requesting_user.id, current_user.id).id, judge: 'permit'), method: :patch, class: 'mx-1') +
      link_to('非承認', user_request_path(requesting_user.id, find_request(requesting_user.id, current_user.id).id, judge: 'reject'), method: :patch, class: 'mx-1')
    elsif status == PermissionRequest::PERMITTED
      '承認済み'
    else
      '非承認'
    end
  end

  def check_requested_user_status(current_user, requested_user)
    request =  PermissionRequest.find_by(sent_from_id: current_user.id, sent_to_id: requested_user.id)
    if request.nil?
      link_to 'リクエスト', new_user_request_path(requested_user)
    elsif request.status == PermissionRequest::DEFAULT
      'リクエスト済み'
    elsif status == PermissionRequest::PERMITTED
      '承認済み'
    else
      '非承認'
    end
  end
end
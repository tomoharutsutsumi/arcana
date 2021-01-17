# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  def facebook
    callback_from('facebook')
  end

  private

  def callback_from(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])

    if session[:hash_string].present?
      list = ShareHash.find_by(hash_string: session[:hash_string]).list
      request = PermissionRequest.create(sent_from_id: @user.id, sent_to_id: list.user.id,  status: PermissionRequest::PERMITTED)
      PermissionList.create(list: list, permission_request: request)
      session[:hash_string].clear
    end

    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end

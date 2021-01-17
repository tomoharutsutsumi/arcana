# frozen_string_literal: true

class Users::OmniauthCallbacksController < Devise::OmniauthCallbacksController
  include RegisterWithSharedList
  def facebook
    callback_from('facebook')
  end

  private

  def callback_from(provider)
    @user = User.from_omniauth(request.env['omniauth.auth'])
    register_with_shared_list(@user)
    if @user.persisted?
      sign_in_and_redirect @user, event: :authentication
    else
      session["devise.#{provider}_data"] = request.env['omniauth.auth']
      redirect_to new_user_registration_url
    end
  end
end

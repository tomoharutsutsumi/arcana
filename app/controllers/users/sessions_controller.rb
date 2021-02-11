# frozen_string_literal: true

class Users::SessionsController < Devise::SessionsController
  include RegisterWithSharedList
  # before_action :configure_sign_in_params, only: [:create]

  # GET /resource/sign_in
  def new
    session[:share_hash] = params[:share_hash] if params.has_key?(:share_hash)
    super
  end


  def create
    self.resource = warden.authenticate!(auth_options)
    register_with_shared_list(resource)
    set_flash_message!(:notice, :signed_in)
    sign_in(resource_name, resource)
    yield resource if block_given?
    respond_with resource, location: after_sign_in_path_for(resource)
  end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end
end

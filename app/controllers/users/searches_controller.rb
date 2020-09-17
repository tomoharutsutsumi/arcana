class Users::SearchesController < ApplicationController
  def index
    @searched_users = User.all.where(email: params[:email])
  end
end
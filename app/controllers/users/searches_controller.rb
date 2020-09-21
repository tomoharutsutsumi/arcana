class Users::SearchesController < ApplicationController
  def index
    @searched_users = User.all.where(email: params[:email]).where.not(id: current_user.id)
  end
end
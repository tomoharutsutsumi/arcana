class Users::SearchesController < ApplicationController
  def index
    @searched_users = User.all.where(name: params[:name]).where.not(id: current_user.id)
    @sent_from_users = current_user.sent_from_users
  end
end
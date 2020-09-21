class Users::SearchesController < ApplicationController
  def index
    @searched_users = User.all.where(name: params[:name]).where.not(id: current_user.id)
  end
end
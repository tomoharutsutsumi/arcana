class Lists::ShareHashesController < ApplicationController
  def create
    list = List.find(params[:list_id])
    list.create_share_hash
    redirect_to list_restaurants_path(list), notice: '共有リンクが発行されました'
  end
end
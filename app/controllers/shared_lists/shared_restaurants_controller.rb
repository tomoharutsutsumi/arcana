class SharedLists::SharedRestaurantsController < ApplicationController
  def show
    list = List.find_by(share_hash: params[:share_hash])
    @shared_restaurant = list.restaurants.find(params[:id])
  end

  private

  def authenticate?
    false
  end
end
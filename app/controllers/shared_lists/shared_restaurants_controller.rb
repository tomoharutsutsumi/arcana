class SharedLists::SharedRestaurantsController < ApplicationController
  def show
    list = ShareHash.find_by(hash_string: params[:hash_string]).list
    @shared_restaurant = list.restaurants.find(params[:id])
  end

  private

  def authenticate?
    false
  end
end
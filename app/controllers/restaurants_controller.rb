class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i(show edit update destroy)
  
  def show; end

  def edit; end

  def update
    @restaurant.update(restaurant_params)
    redirect_to list_restaurants_path(@restaurant.list)
  end

  def destroy
    @restaurant.delete
    redirect_to list_restaurants_path(@restaurant.list)
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(:url, :price, :comment, :participant, :name, :place, :recommended_menu, :category)
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
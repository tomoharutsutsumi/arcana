class Lists::RestaurantsController < ApplicationController
  before_action :set_list, only: %i(index new create)
  
  def index
    @restaurants = @list.restaurants
  end

  def new
    @results = Restaurant.get_info_from_api(params[:name]) if params.has_key?(:name)
    @restaurant = @list.restaurants.build
  end

  def create
    @restaurant = @list.restaurants.build(restaurant_params)
    @restaurant.save
    redirect_to list_restaurants_path(@list)
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:url, :price, :comment, :participant, :name, :place, :recommended_menu, :category)
  end
end

class Lists::RestaurantsController < ApplicationController
  before_action :set_list, only: %i(index new create)
  
  def index
    @restaurants = @list.restaurants
  end

  def new
    @results = Restaurant.get_info_from_api(params[:name]) if params.has_key?(:name)
  end

  def create
    @restaurant = @list.restaurants.build(restaurant_params.merge(
      name: params[:restaurant][:name],
      price: params[:restaurant][:budget][:name],
      place: params[:restaurant][:address],
      category: params[:restaurant][:genre][:catch],
      url: params[:restaurant][:urls][:pc],
    ))
    @restaurant.save
    redirect_to new_list_restaurant_path(@list), notice: 'お店を登録しました'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def restaurant_params
    params.require(:restaurant).permit(:comment, :participant, :recommended_menu)
  end
end

class Lists::RestaurantsController < ApplicationController
  before_action :set_list, only: %i(index new create)
  
  def index
    @restaurants = @list.restaurants
  end

  def new
    @searched = params.has_key?(:freeword)
    if @searched
      @results = RestaurantFinder.new.find(params[:freeword])
      @restaurant = @list.restaurants.build
    end
    @link = list_restaurants_path(@list)
  end

  def create
    @restaurant = @list.restaurants.build(restaurant_params.merge(additional_restaurant_params).merge(access_params))
    @restaurant.save
    redirect_to new_list_restaurant_path(@list), notice: 'お店を登録しました'
  end

  private

  def set_list
    @list = List.find(params[:list_id])
  end

  def restaurant_params
    params.require(:restaurant).permit(
      :name, :comment, :participant, 
      :recommended_menu, :tel, :url, 
      :opentime, :holiday,
    )
  end

  def additional_restaurant_params
    h = {
      price: params[:restaurant][:budget],
      place: params[:restaurant][:address],
      category: params[:restaurant][:category],
    } 
    if params[:restaurant][:image_url].present?
      h.merge({ image: params[:restaurant][:image_url][:shop_image1] })
    end
  end

  def access_params
    if params[:restaurant][:combined_access].present?
      { combined_access: params[:restaurant][:combined_access] }
    else
      if params[:restaurant][:access].present?
        { 
          line: params[:restaurant][:access][:line],
          station: params[:restaurant][:access][:station],
          station_exit: params[:restaurant][:access][:station_exit],
          walk: params[:restaurant][:access][:walk] 
        }
      end
    end
  end
end

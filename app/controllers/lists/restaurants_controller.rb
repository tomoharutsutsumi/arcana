class Lists::RestaurantsController < ApplicationController
  before_action :set_list, only: %i(index new create)
  
  def index
    @restaurants = @list.restaurants
  end

  def new
    @searched = params.has_key?(:name)
    if @searched
      @results = Restaurant.get_info_from_api(params[:name], params[:katakana])
      @restaurant = @list.restaurants.build
    end
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
    {
      price: params[:restaurant][:budget],
      place: params[:restaurant][:address],
      category: params[:restaurant][:category],
    }
  end

  def access_params
    if params[:restaurant][:combined_access].present?
      { combined_access: params[:restaurant][:combined_access] }
    else
      { 
        line: params[:restaurant][:access][:line],
        station: params[:restaurant][:access][:station],
        station_exit: params[:restaurant][:access][:station_exit],
        walk: params[:restaurant][:access][:walk] 
      }
    end
  end
end

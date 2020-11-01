class RestaurantsController < ApplicationController
  before_action :set_restaurant, only: %i(show edit update destroy)
  
  def show; end

  def edit; end

  def update
    @restaurant.update(restaurant_params)
    redirect_to list_restaurants_path(@restaurant.list), notice: 'お店を編集しました'
  end

  def destroy
    @restaurant.delete
    redirect_to list_restaurants_path(@restaurant.list), notice: 'お店を削除しました'
  end

  private

  def restaurant_params
    params.require(:restaurant).permit(
      :url, :comment, :participant, 
      :name, :recommended_menu, :tel, 
      :combined_access, :opentime, :holiday,
    )
  end

  def additional_restaurant_params
    {
      price: params[:restaurant][:budget],
      place: params[:restaurant][:address],
      category: params[:restaurant][:category],
    }
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:id])
  end
end
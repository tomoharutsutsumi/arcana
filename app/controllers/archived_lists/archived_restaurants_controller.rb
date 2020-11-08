class ArchivedLists::ArchivedRestaurantsController < ApplicationController
  def index
    @archived_restaurants = ArchivedList.find(params[:archived_list_id]).archived_restaurants
  end

  def show
    @archived_restaurant = ArchivedRestaurant.find(params[:id])
  end
end
module RestaurantHelper
  def restaurant_access(restaurant)
    restaurant.combined_access.present? ? 
      restaurant.combined_access : 
      combine_access_info(restaurant)
  end

  private

  def combine_access_info(restaurant)
    line = restaurant.line.present? ? restaurant.line : ''
    station = restaurant.station.present? ? restaurant.station : ''
    station_exit = restaurant.station_exit.present? ? restaurant.station_exit : ''
    walk = restaurant.walk.present? ? '徒歩' + restaurant.walk.to_s + '分' : ''
    line + station + station_exit + walk
  end
end
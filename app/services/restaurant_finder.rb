class RestaurantFinder
  require 'net/http'

  def find(name)
    api = get_restaurants_from_api(name)
    original = get_restaurants_from_original(name)
    if api && original
      api + original
    elsif api
      api 
    elsif original
      original
    else 
      nil
    end
  end

  private

  def get_restaurants_from_api(name)
    request_url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=' << ENV['GURUNAVI_API_KEY'] << "&freeword=#{name}"
    request_url = URI.encode(request_url)
    request_url = URI.parse(request_url)
    results = Net::HTTP.get(request_url)
    results = JSON.parse(results)
    results = results['rest']
  end

  def get_restaurants_from_original(name)
    results = OriginalRestaurant.where("name LIKE ?", "%#{name}%")
    format(results)
  end

  def format(results)
    results.map{|r| {"name" => r.name, "price" => r.price, "url" => r.url,
                     "category" => r.category, "place" => r.place, 
                     "tel" => r.tel, "opentime" => r.opentime, "holiday" => r.holiday,
                     "combined_access" => r.combined_access, "image_url" => {}}}
  end
end



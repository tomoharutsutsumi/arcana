class Restaurant < ApplicationRecord
  require 'net/http'
  belongs_to :list

  def self.get_info_from_api(name)
    request_url = 'https://api.gnavi.co.jp/RestSearchAPI/v3/?keyid=' << ENV['GURUNAVI_API_KEY'] << "&freeword=#{name}"
    request_url = URI.encode(request_url)
    request_url = URI.parse(request_url)
    results = Net::HTTP.get(request_url)
    results = JSON.parse(results)
    results = results['rest'] #original_restaurantと一緒にサービスモデルにいれる
  end
end

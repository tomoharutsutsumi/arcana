class Restaurant < ApplicationRecord
  require 'net/http'
  belongs_to :list
  has_many :participants

  def self.get_info_from_api(name)
    request_url = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=' << ENV['HOTPEPPER_API_KEY'] << "&name=#{name}"
    request_url = URI.encode(request_url)
    request_url = URI.parse(request_url)
    results = Hash.from_xml Net::HTTP.get(request_url)
    results = results['results']['shop']
  end
end

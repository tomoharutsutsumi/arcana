class Restaurant < ApplicationRecord
  belongs_to :list
  has_many :participants

  def self.get_info_from_api(name)
    request_url = 'http://webservice.recruit.co.jp/hotpepper/gourmet/v1/?key=' << ENV['HOTPEPPER_API_KEY'] << "&name=#{name}"
    request_url = URI.encode(request_url)
    results = Hash.from_xml open(request_url).read
    results = results['results']['shop']
  end
end

class ArchivedRestaurant < ApplicationRecord
  belongs_to :archived_list

  def self.archive(archived_list, list)
    list.restaurants.each do |r|
      archived_list.archived_restaurants.create(price: r.price, comment: r.comment, url: r.url,
                                                participant: r.participant, name: r.name, category: r.category,
                                                place: r.place, recommended_menu: r.recommended_menu, tel: r.tel,
                                                opentime: r.opentime, holiday: r.holiday, combined_access: r.combined_access,
                                                line: r.line, station: r.station, station_exit: r.station_exit, walk: r.walk, image: r.image)
    end
  end
end
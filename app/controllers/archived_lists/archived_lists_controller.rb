class ArchivedLists::ArchivedRestaurantsController < ApplicationController
  def index

  end

  private

  def set_list
    @archived_list = ArchivedList.find(params[:list_id])
  end
end
class Restaurants::RequestsController < ApplicationController
  def create
    name = params[:name]
    RestaurantRequestMailer.request_mail(name).deliver_now!
    redirect_to request.referer, notice: 'リクエストを送りました'
  end
end
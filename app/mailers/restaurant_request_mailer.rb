class RestaurantRequestMailer < ApplicationMailer
  def request_mail(name)
    @name = name
    mail(to: AdminUser.all.map(&:email), subject: '[アルカナ] お店登録のリクエストが届いています')
  end
end

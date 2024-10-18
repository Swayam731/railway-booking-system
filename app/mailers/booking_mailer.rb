class BookingMailer < ApplicationMailer
  default from: email_address_with_name('swayam@gmail.com', "Railway Booking System")

  def booking_email(user)
    @user = user
    mail(to: @user.email, subject: "Your Booking was successfull")
  end

end

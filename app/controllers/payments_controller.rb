class PaymentsController < ApplicationController
  def new
    @ticket = Ticket.find(params[:ticket])
  end

  def create
    customer = Stripe::Customer.create({
      :email => params[:stripeEmail],
      :source => params[:stripeToken]
    })

    charge = Stripe::Charge.create({
      :customer => customer.id,
      :amount => 500,
      :description => 'Description of your product',
      :currency => 'gbp'
    })
    BookingMailer.booking_email(current_user).deliver_now
    redirect_to ticket_path(id: Ticket.last.id) and return
    rescue Stripe::CardError => e
      flash[:error] = e.message
  end
end

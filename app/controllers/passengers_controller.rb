class PassengersController < ApplicationController
  def new
    @passenger = Passenger.new
    @ticket_id = params[:ticket_id]
    ticket = Ticket.find(@ticket_id)
    @number_of_passenger = ticket.number_of_passenger
  end

  def create
    @ticket_id = params[:ticket_id]
    @passenger = Passenger.new(passenger_params)
    if @passenger.save
      redirect_to edit_ticket_path(@passenger.ticket_id)
    else
      render :new
    end
  end

  private
  def passenger_params
    params.require(:passenger).permit(:name, :age, :name2, :age2, :ticket_id)
  end

end

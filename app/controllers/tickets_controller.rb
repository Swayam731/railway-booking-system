class TicketsController < ApplicationController

  def index
    @tickets = current_user.tickets
  end

  def new
    @ticket = Ticket.new
    @source = params[:source]
    @destination = params[:destination]
    @train_id = params[:train_id]
  end

  def create
    @source = params[:source]
    @destination = params[:destination]
    @train_id = params[:train_id]
    @number_of_passenger = params[:number_of_passenger]
    @journey_class = params[:journey_class]
    @date = params[:date]
    @user_id = params[:user_id]
    @ticket = Ticket.new(ticket_params)
    @seats = JourneyClass.where(train_id: @ticket.train_id, class_type: @ticket.journey_class).pick(:available_seats)
    byebug
    if !@ticket&.number_of_passenger
     flash[:notice] = "please provide number of passenger"
     render :new
    else
      if @seats < @ticket&.number_of_passenger
        flash[:notice] = "#{@seats} Seats left only"
        render :new
      elsif @seats<1
        flash[:notice] = "No Seat left for #{@ticket.journey_class}"
        render :new
      else
        if @ticket.save
          redirect_to new_passenger_path(ticket_id: @ticket.id, source: @source, destination: @destination, train_id: @train_id, number_of_passenger: @number_of_passenger, journey_class: @journey_class, date: @date)
        else
          flash[:notice] = "Something went wrong"
          render :new
        end
      end
    end
  end

  def show
    @ticket = Ticket.find(params[:id])
  end

  def edit
    @ticket = Ticket.find(params[:id])
    @passengers = Passenger.find_by(ticket_id: @ticket.id)
    @fare = Ticket.calculate_fare(@ticket.source, @ticket.destination, @ticket.train_id, @ticket.journey_class)
    @fare = @fare*@ticket.number_of_passenger.to_f
  end

  def update
    @ticket = Ticket.find(params[:id])
    @seat_number = Ticket.decrement_seat_counter(@ticket.train_id, @ticket.journey_class, @ticket.number_of_passenger)
    @ticket.seat_number = @seat_number
    @ticket.coach_name = "S1" if @ticket.journey_class=="Sleeper" && @seat_number>=75
    @ticket.coach_name = "S2" if @ticket.journey_class=="Sleeper" && @seat_number>=50
    @ticket.coach_name = "S3" if @ticket.journey_class=="Sleeper" && @seat_number>=25
    @ticket.coach_name = "S4" if @ticket.journey_class=="Sleeper" && @seat_number>=1
    @ticket.coach_name = "A1" if @ticket.journey_class=="First AC" && @seat_number>=1
    @ticket.coach_name = "B1" if @ticket.journey_class=="Second AC" && @seat_number>=25
    @ticket.coach_name = "B2" if @ticket.journey_class=="Second AC" && @seat_number>=1

    if @ticket.save
      BookingMailer.booking_email(current_user).deliver_now
      redirect_to @ticket
    else
      render :edit
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:source, :destination, :train_id, :user_id, :journey_class, :number_of_passenger, :date)
  end
end

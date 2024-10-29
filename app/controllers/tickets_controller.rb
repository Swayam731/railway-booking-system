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
    day_name = @ticket.date.strftime('%A').downcase
    day = Day.find_by(name: day_name)
    journey_class = JourneyClass.find_by(class_type: @ticket.journey_class, train_id: @ticket.train_id)
    @seats = DailyAvailability.where(train_id: @ticket.train_id, journey_class_id: journey_class.id, day_id: day.id).pick(:available_seats)
    if !@ticket&.number_of_passenger
     flash[:error] = "please provide number of passenger!"
     respond_to do |format|
      format.js { render 'error' }
     end
    else
      if @seats < @ticket&.number_of_passenger
        flash[:error] = "#{@seats} Seats left only!"
        respond_to do |format|
          format.js { render 'error' }
        end
      elsif @seats<1
        flash[:error] = "No Seat left for #{@ticket.journey_class}!"
        respond_to do |format|
          format.js { render 'error' }
        end
      else
        if @ticket.save
          redirect_to new_passenger_path(ticket_id: @ticket.id, source: @source, destination: @destination, train_id: @train_id, number_of_passenger: @number_of_passenger, journey_class: @journey_class, date: @date)
        else
          flash[:error] = "Something went wrong"
          respond_to do |format|
            format.js { render 'error' }
          end
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
    @fare = (@fare*@ticket.number_of_passenger).to_f
    @ticket.update(fare: @fare)
  end

  def update
    @ticket = Ticket.find(params[:id])
    @seat_number = Ticket.decrement_seat_counter(@ticket.train_id, @ticket.journey_class, @ticket.number_of_passenger, @ticket.date)
    @ticket.seat_number = @seat_number
    # @ticket.coach_name = "S1" if @ticket.journey_class=="sleeper" && @seat_number>=50
    # @ticket.coach_name = "S2" if @ticket.journey_class=="sleeper" && @seat_number>=25
    # @ticket.coach_name = "S3" if @ticket.journey_class=="sleeper" && @seat_number>=1
    # @ticket.coach_name = "A1" if @ticket.journey_class=="first AC" && @seat_number>=50
    # @ticket.coach_name = "A2" if @ticket.journey_class=="first AC" && @seat_number>=25
    # @ticket.coach_name = "A3" if @ticket.journey_class=="first AC" && @seat_number>=1
    # @ticket.coach_name = "B1" if @ticket.journey_class=="second AC" && @seat_number>=50
    # @ticket.coach_name = "B2" if @ticket.journey_class=="second AC" && @seat_number>=25
    # @ticket.coach_name = "B3" if @ticket.journey_class=="second AC" && @seat_number>=1
    @ticket.assign_coach
    if @ticket.save
      redirect_to new_payment_path(ticket: @ticket)
    else
      render :edit
    end
  end

  private

  def ticket_params
    params.require(:ticket).permit(:source, :destination, :train_id, :user_id, :journey_class, :number_of_passenger, :date)
  end
end

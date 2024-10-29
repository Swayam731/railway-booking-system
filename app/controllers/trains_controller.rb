class TrainsController < ApplicationController

  def search
    from_station = params[:source_station]
    to_station = params[:destination_station]
    @source_station = Station.find_by_name(from_station)
    @destination_station = Station.find_by_name(to_station)
    @date = params[:date]

    @source_error = nil
    @destination_error = nil
    @date_error = nil

    if !@source_station.present?
      @source_error = "Please provide a source station."
    end

    if !@destination_station.present?
      @destination_error = "Please provide a destination station."
    end

    if !@date.present?
      @date_error = "Date cannot be empty."
    elsif @date.to_date < Date.today
      @date_error = "Date cannot be in the past."
    end

    if @source_error || @destination_error || @date_error
      render :search
    else
      @trains = Train.search_train(@source_station, @destination_station, @date)
      @trains.each do |train|
        stops = Stop.where(train_id: train.id, station_id: @source_station.id)
        stops.each do |stop|
          new_departure_time = DateTime.parse(@date) + stop.departure_time.hour.hours + stop.departure_time.min.minutes
          stop.update!(departure_time: new_departure_time)
        end
      end
      render 'search_result'
    end
  end

  def search_result
    @train_id = params[:train_id]
    @source = params[:source]
    @destination = params[:destination]
    redirect_to new_ticket_path(train_id: @train_id, source: @source, destination: @destination)
  end

  def index
    render :search
  end

  def new
    @train = Train.new
  end

  def create
    # @train = Train.new
    # if @train.save
    #   redirect_to @train
    # else
    #   render :new
    # end
  end

  def show
    # @train = Train.find(params[:id])
  end

  def edit
    # @train = Train.find(params[:id])
  end

  def update
    # @train = Train.find(params[:id])
    # if @train.update
    #   redirect_to @train
    # else
    #   render :edit
    # end
  end

  def destroy
    # @train = Train.find(params[:id])
    # @train.destroy
    # redirect_to root_path
  end

end

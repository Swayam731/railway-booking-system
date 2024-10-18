class TrainsController < ApplicationController

  def search
    from_station = params[:source_station]
    to_station = params[:destination_station]
    @source_station = Station.find_by_name(from_station)
    @destination_station = Station.find_by_name(to_station)
    @date = params[:date]

    @trains = Train.search_train(@source_station, @destination_station, @date)
    render 'search_result'
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
    @train = Train.new
    if @train.save
      redirect_to @train
    else
      render :new
    end
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

class PassengersController < ApplicationController
  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]

    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger
      redirect_to passengers_path
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def create
    @passenger = Passenger.new(passenger_params)

    @passenger.save

    redirect_to passengers_path
  end

  def edit
    passenger_id = params[:id]

    @passenger = Passenger.find_by(id: passenger_id)

    unless @passenger
      redirect_to passengers_path
      return
    end
  end

  def update
    passenger = Passenger.find_by(id: params[:id])

    unless passenger
      redirect_to passengers_path
      return
    end
  end

  def destroy
    passenger = Passenger.find_by(id: params[:id])

    unless task
      head :not_found
      return
    end

    passenger.destroy

    redirect_to passengers_path
  end

  private 

  def passenger_params
    return params.require(:passenger).permit(:)
  end
end

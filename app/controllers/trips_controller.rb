class TripsController < ApplicationController
  def index
    if params[:passenger_id]
      passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = passenger.trips
    elsif params[:driver_id]
      driver = Driver.find_by(id: params[:driver_id])
      @trips = driver.trips
    else
      @trips = Trip.all
    end
  end

  def create
    trip_cost = rand(1...100)
    trip_driver = (Driver.all).sample.id

    trip = Trip.new(date: Date.current, cost: trip_cost, passenger_id: params[:passenger_id], driver_id: trip_driver)

    trip.save

    redirect_to passenger_path(params[:passenger_id])
  end

  def show
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      redirect_to trip_path
    end
  end

  def edit
    trip_id = params[:id]

    @trip = Trip.find_by(id: trip_id)

    unless @trip
      redirect_to trip_path
    end
  end

  def update
    trip = Trip.find_by(id: params[:id])

    unless trip
      redirect_to root_path
      return
    end

    trip.update(trip_params)

    redirect_to trip_path(trip)
  end

  def destroy
    trip_id = params[:id]
    trip = Trip.find_by(id: trip_id)

    unless trip
      head :not_found
      return
    end

    trip.destroy

    redirect_to trips_path
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :rating, :cost)
  end
end

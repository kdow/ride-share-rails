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
    trip_cost = rand(100...10000)
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
    trip_id = params[:id]

    @trip = Trip.find(trip_id)

    unless @trip
      redirect_to root_path
      return
    end

    @trip.update(trip_params)

    redirect_to trip_path(trip)
  end

  def add_rating
    trip = Trip.find(params[:id])

    trip.rating = params[:rating]

    if trip.passenger_id
      trip.update!({id: trip.id, rating: params[:rating]})
    else
      redirect_to trip_path(trip)
    end

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

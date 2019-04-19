require "test_helper"

describe TripsController do
  before do
    @pass = Passenger.create!(name: "sample passenger", phone_num: "9999999999")
    @driver = Driver.create!(name: "sample driver", vin: "f09ahw3u43087fif097f")
    @trip = Trip.create!(date: Date.current, cost: 2197, passenger_id: @pass.id, driver_id: @driver.id)
  end

  describe "show" do
    it "can get a valid trip" do
      get trip_path(@trip.id)

      must_respond_with :success
    end

    it "will redirect for an invalid trip" do
      get trip_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing trip" do
      get edit_trip_path(@trip.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant trip" do
      get edit_trip_path(-1)

      must_respond_with :redirect
      must_redirect_to trips_path
    end
  end

  describe "update" do
    it "can update an existing driver" do
      test_trip = @trip

      trip_data = {
        trip: {
          cost: 1078,
        },
      }

      expect {
        patch trip_path(test_trip.id), params: trip_data
      }.wont_change "Trip.count"

      must_respond_with :redirect
      must_redirect_to trip_path(test_trip)

      test_trip.reload
      expect(test_trip.cost).must_equal(trip_data[:trip][:cost])
    end

    it "returns a 404 if given an invalid id" do
      patch trip_path(-1)

      must_respond_with :not_found
    end
  end

  describe "create" do
    it "can create a new trip" do
      trip_hash = {
        trip: {
          date: Date.current,
          cost: 5287,
          passenger_id: @pass.id,
          driver_id: @driver.id,
        },
      }

      expect {
        post passenger_trips_path(@pass.id), params: trip_hash
      }.must_change "Trip.count", 1

      new_trip = Trip.find_by(driver_id: trip_hash[:trip][:driver_id])
      expect(new_trip.passenger_id).must_equal trip_hash[:trip][:passenger_id]

      must_respond_with :redirect
      must_redirect_to passenger_path(@pass.id)
    end
  end

  describe "destroy" do
    it "removes the trip from the database" do
      test_trip = Trip.create!(date: Date.current, cost: 2197, passenger_id: @pass.id, driver_id: @driver.id)

      expect {
        delete trip_path(test_trip)
      }.must_change "Trip.count", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to trips_path

      after_trip = Trip.find_by(id: test_trip.id)
      expect(after_trip).must_be_nil
    end

    it "returns a 404 if the trip does not exist" do
      trip_id = 999999999999999999999999999999999999

      expect(Trip.find_by(id: trip_id)).must_be_nil

      expect {
        delete trip_path(trip_id)
      }.wont_change "Trip.count"

      # Assert
      must_respond_with :not_found
    end
  end
end

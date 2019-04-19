require "test_helper"

describe PassengersController do
  before do
    @pass = Passenger.create!(name: "Bob Bob", phone_num: "555-555-5555")
  end

  describe "index" do
    it "can get the index path" do
      get passengers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid passenger" do
      get passenger_path(@pass.id)

      must_respond_with :success
    end

    it "will redirect for an invalid passenger" do
      get passenger_path(-55)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing passenger" do
      get edit_passenger_path(@pass.id)

      must_respond_with :ok
    end

    it "will respond with redirect when attempting to edit a nonexistant passenger" do
      get edit_passenger_path(555555555)

      must_redirect_to passengers_path
    end
  end

  describe "update" do
    it "will update an existing passenger" do
      superstar = Passenger.create!(name: "Superstar", phone_num: "444444")
      superstar_updates = {passenger: {name: "Sarah Smith",
                                       phone_num: "333333"}}

      patch passenger_path(superstar), params: superstar_updates

      superstar.reload
      expect(superstar.name).must_equal "Sarah Smith"
    end
  end

  describe "new" do
    it "can get the new passenger page" do
      get new_passenger_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new passenger" do
      passenger_hash = {
        passenger: {
          name: "Ronald Weasley",
          phone_num: "12300099",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1

      new_passenger = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(new_passenger.phone_num).must_equal passenger_hash[:passenger][:phone_num]

      must_respond_with :redirect
      must_redirect_to passengers_path
    end

    it "won't create a passenger with a missing param" do
      passenger_hash = {
        passenger: {
          phone_num: "12300099",
        },
      }

      expect {
        post passengers_path, params: passenger_hash
      }.wont_change "Passenger.count"
    end
  end

  describe "destroy" do
    it "removes the record of the passenger from the database" do
      new_pass = Passenger.create!(name: "new", phone_num: "333-3333")

      expect {
        delete passenger_path(new_pass.id)
      }.must_change "Passenger.count", -1

      must_respond_with :redirect
    end
  end
end

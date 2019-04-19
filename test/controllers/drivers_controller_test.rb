require "test_helper"

describe DriversController do
  let (:driver) {
    Driver.create name: "sample driver", vin: "f09ahw3u43087fif097f"
  }

  describe "index" do
    it "can get index" do
      get drivers_path

      must_respond_with :success
    end
  end

  describe "show" do
    it "can get a valid driver" do
      get driver_path(driver.id)

      must_respond_with :success
    end

    it "will redirect for an invalid driver" do
      get driver_path(-1)

      must_respond_with :redirect
    end
  end

  describe "edit" do
    it "can get the edit page for an existing driver" do
      get edit_driver_path(driver.id)

      must_respond_with :success
    end

    it "will respond with redirect when attempting to edit a nonexistant driver" do
      get edit_driver_path(-1)

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "update" do
    it "can update an existing driver" do
      test_driver = driver
      driver_data = {
        task: {
          name: "new name",
        },
      }

      expect {
        patch driver_path(test_driver), params: driver_data
      }.wont_change "Driver.count"

      must_respond_with :redirect
      must_redirect_to driver_path(test_driver)

      test_driver.reload
      expect(test_driver.name).must_equal(driver_data[:driver][:name])
    end

    it "returns a 404 if given an invalid id" do
      patch driver_path(-1)

      must_respond_with :not_found
    end
  end

  describe "new" do
    it "can get the new driver page" do
      get new_driver_path

      must_respond_with :success
    end
  end

  describe "create" do
    it "can create a new driver" do
      driver_hash = {
        driver: {
          name: "new driver",
          vin: "1111111111111111",
        },
      }

      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1

      new_driver = Driver.find_by(name: driver_hash[:driver][:name])
      expect(new_driver.vin).must_equal driver_hash[:driver][:vin]

      must_respond_with :redirect
      must_redirect_to drivers_path
    end
  end

  describe "destroy" do
    it "removes the driver from the database" do
      driver = Driver.create!(name: "driver", vin: "000000000000000")

      expect {
        delete driver_path(driver)
      }.must_change "Driver.count", -1

      # Assert
      must_respond_with :redirect
      must_redirect_to drivers_path

      after_driver = Driver.find_by(id: driver.id)
      expect(after_driver).must_be_nil
    end

    it "returns a 404 if the driver does not exist" do
      driver_id = 999999999999999999999999999999999999

      expect(Driver.find_by(id: driver_id)).must_be_nil

      expect {
        delete driver_path(driver_id)
      }.wont_change "Driver.count"

      # Assert
      must_respond_with :not_found
    end
  end
end

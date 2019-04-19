class RemoveCostDecimalFromTrips < ActiveRecord::Migration[5.2]
  def change
    remove_column :trips, :cost_decimal
  end
end

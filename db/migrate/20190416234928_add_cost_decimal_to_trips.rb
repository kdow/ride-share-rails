class AddCostDecimalToTrips < ActiveRecord::Migration[5.2]
  def change
    add_column :trips, :cost_decimal, :decimal, :precision => 12, :scale => 2
  end
end

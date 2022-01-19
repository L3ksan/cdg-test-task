class AddDistanceAndPriceToDeliveries < ActiveRecord::Migration[7.0]
  def change
    add_column :deliveries, :distance, :float
    add_column :deliveries, :price, :decimal
  end
end

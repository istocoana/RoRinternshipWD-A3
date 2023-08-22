class AddOutOfStockToOrderItems < ActiveRecord::Migration[7.0]
  def change
    add_column :order_items, :out_of_stock, :boolean, default: false
  end
end

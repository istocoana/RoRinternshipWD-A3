class UpdateForeignKeyOnOrderItems < ActiveRecord::Migration[7.0]
  def change
    remove_foreign_key :order_items, :products

    add_foreign_key :order_items, :products, on_delete: :nullify
  end
end

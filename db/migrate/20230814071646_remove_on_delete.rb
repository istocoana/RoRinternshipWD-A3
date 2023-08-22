class RemoveOnDelete < ActiveRecord::Migration[7.0]
  def change
    def change
      remove_foreign_key :order_items, :products, on_delete: :nullify
  
      add_foreign_key :order_items, :products
    end
  end
end

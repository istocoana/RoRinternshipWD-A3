class CreateOrders < ActiveRecord::Migration[7.0]
  def change
    create_table :orders do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :status, default: 0
      t.date :order_date
      t.date :completed_order_date

      t.timestamps
    end
  end
end

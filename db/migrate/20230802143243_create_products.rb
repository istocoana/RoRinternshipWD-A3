class CreateProducts < ActiveRecord::Migration[7.0]
  def change
    create_table :products do |t|
      t.string :title, null: false
      t.string :description, null: false
      t.decimal :price, null: false
      t.boolean :vegetarian, default: false, null: false
      t.integer :category, default: 0, null: false

      t.timestamps
    end
  end
end

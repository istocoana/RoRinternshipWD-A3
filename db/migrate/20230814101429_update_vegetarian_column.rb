class UpdateVegetarianColumn < ActiveRecord::Migration[7.0]
  def change
    change_column :products, :vegetarian, :boolean, default: false, null: true

  end
end

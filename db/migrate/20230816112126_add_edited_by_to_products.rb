class AddEditedByToProducts < ActiveRecord::Migration[7.0]
  def change
    add_column :products, :edited_by, :integer
  end
end

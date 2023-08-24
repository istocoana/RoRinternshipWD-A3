class ProductSerializer < ApplicationSerializer
  attributes :title, :description, :price, :category, :vegetarian

  # has_many :order_items, serializer: OrderItemsSerializer
  # has_many :orders, serializer: OrderSerializer
end

  

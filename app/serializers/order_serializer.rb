class OrderSerializer < ApplicationSerializer 
  attributes :id, :status, :order_date, :completed_order_date
end

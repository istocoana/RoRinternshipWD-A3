class UserSerializer < ApplicationSerializer
  attributes :id, :email, :password, :role 
  
  # has_one :profile, serializer: ProfileSerializer 
  # has_many :orders, serializer: OrderSerializer
end

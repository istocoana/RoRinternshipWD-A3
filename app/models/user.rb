class User < ApplicationRecord

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  
  has_one :profile
  has_many :orders, class_name: "Order"

  validates :email, presence: true
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :role, inclusion: { in: ['admin', 'customer'] }
       
       
  accepts_nested_attributes_for :profile
end

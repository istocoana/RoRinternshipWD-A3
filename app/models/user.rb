class User < ApplicationRecord
  devise  :database_authenticatable, 
          :registerable,
          :validatable
         
  has_one :profile, dependent: :destroy
  has_many :orders, class_name: "Order", dependent: :destroy

  validates :email, presence: true, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :password, presence: true, confirmation: true
  validates :password_confirmation, presence: true
  validates :role, inclusion: { in: ['admin', 'customer'] }

  accepts_nested_attributes_for :profile

end

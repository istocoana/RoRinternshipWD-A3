class Product < ApplicationRecord
  has_one_attached :photo, service: :cloudinary
  has_many :order_items, dependent: :destroy
  has_many :orders, through: :order_items

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { minimum: 10, too_long: "%{count} characters is the maximum allowed" }
  validates :price, numericality: { greater_than_or_equal_to: 0 }, unless: -> { price.blank? } 
  validates :category, presence: true
  validates :photo, presence: :true
  validates :vegetarian, inclusion: { in: [true, false] }, allow_nil: true

  enum category: { 
    main_course: 0, 
    salad: 1,
    appetizer: 2, 
    dessert: 3, 
    drink: 4
   }
    

end

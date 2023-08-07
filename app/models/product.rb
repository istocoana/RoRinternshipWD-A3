class Product < ApplicationRecord

  validates :title, presence: true, length: { maximum: 250 }
  validates :description, presence: true, length: { minimum: 1000, too_long: "%{count} characters is the maximum allowed" }
  validates :price, :vegetarian, :category, presence: true

  has_one_attached :photo

  enum category: { 
    main_course: 0, 
    salad: 1,
    appetizer: 2, 
    dessert: 3, 
    drink: 4
   }
    
end

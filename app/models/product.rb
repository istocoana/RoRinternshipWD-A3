class Product < ApplicationRecord

  has_one_attached :photo

  enum category: { 
    main_course: 0, 
    salad: 1,
    appetizer: 2, 
    dessert: 3, 
    drink: 4
   }
    
end

product1 = Product.create(
  title: 'Spaghetti Bolognese',
  description: 'This ultimate pasta recipe is a total classic, delicious, and super-easy to knock together.',
  price: 12.99,
  category: 2,
  vegetarian: false
)
product1.photo.attach(io: File.open(Rails.root.join('app/assets/images/bolognese.png')), filename: 'bolognese.png')

product2 = Product.create(
  title: 'Caesar Salad',
  description: 'Our Caesar Salad features crisp romaine lettuce, house-made Caesar dressing, croutons, and freshly grated Parmesan cheese. Topped with grilled chicken breast and garnished with cherry tomatoes. A delightful blend of textures and flavors that makes for a satisfying and healthy meal.',
  price: 10.50,
  category: 1,
  vegetarian: false
)
product2.photo.attach(io: File.open(Rails.root.join('app/assets/images/salad.png')), filename: 'salad.png')

product3 = Product.create(
  title: 'Chicken Parmesan',
  description: 'Delicious Chicken Parmesan served with marinara sauce and melted mozzarella cheese.',
  price: 9.55,
  category: 3,
  vegetarian: false
)
product3.photo.attach(io: File.open(Rails.root.join('app/assets/images/pui.png')), filename: 'pui.png')

product4 = Product.create(
  title: 'Beef Stroganoff',
  description: 'Classic Beef Stroganoff with tender strips of beef in a creamy mushroom sauce.',
  price: 15.00,
  category: 3,
  vegetarian: false
)
product4.photo.attach(io: File.open(Rails.root.join('app/assets/images/beef.png')), filename: 'beef.png')

product5 = Product.create(
  title: 'Grilled Salmon',
  description: 'Savor the flavors of our perfectly grilled salmon fillet. Marinated in a delicate blend of lemon zest, garlic, and fresh dill, the salmon is served alongside a medley of roasted vegetables and a lemon-butter sauce. A nutritious and mouthwatering choice.',
  price: 20.99,
  category: 3,
  vegetarian: false
)
product5.photo.attach(io: File.open(Rails.root.join('app/assets/images/fish.png')), filename: 'fish.png')

product6 = Product.create(
  title: 'Soup',
  description: 'Nutrient-packed salad with a mix of fresh greens, colorful vegetables, and tangy vinaigrette.',
  price: 12.03,
  category: 2,
  vegetarian: true
)
product6.photo.attach(io: File.open(Rails.root.join('app/assets/images/salad.png')), filename: 'salad2.png')

product7 = Product.create(
  title: 'Alfredo Pasta',
  description: 'Creamy Alfredo pasta with fettuccine noodles and a rich Parmesan cheese sauce.',
  price: 6.50,
  category: 3,
  vegetarian: false
)
product7.photo.attach(io: File.open(Rails.root.join('app/assets/images/bolognese.png')), filename: 'bolognese2.png')

product8 = Product.create(
  title: 'Alfredo Pasta',
  description: 'Creamy Alfredo pasta with fettuccine noodles and a rich Parmesan cheese sauce.',
  price: 6.50,
  category: 0,
  vegetarian: false
)
product8.photo.attach(io: File.open(Rails.root.join('app/assets/images/bolognese.png')), filename: 'bolognese2.png')

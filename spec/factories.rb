FactoryBot.define do 
  factory :product do
    title { Faker::Lorem.sentence }
    description { Faker::Lorem.paragraph }
    price { Faker::Number.decimal(l_digits: 2) }
    vegetarian { false }
    category { 'main_course' }
    edited_by { nil }
    photo { Rack::Test::UploadedFile.new(Rails.root.join('spec/support/salad.png')) }
  end

  factory :order do 
    association :user
    status { 0 }
    order_date { Date.today }
    completed_order_date { nil }
  end

  factory :order_item do
    association :order
    association :product
    quantity { 1 }
    out_of_stock { false }
  end

  factory :profile do 
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    phone { Faker::PhoneNumber.phone_number }
    street_address { Faker::Address.street_address }
    city { Faker::Address.city }
    county { Faker::Address.state }
    association :user
  end

  factory :user do
    email { Faker::Internet.email }
    password { '123456' }
    password_confirmation { password }
    role { 'customer' }


    after(:create) do |user|
      create(:profile, user: user)
    end
  end
end

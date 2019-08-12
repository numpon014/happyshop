FactoryBot.define do
  factory :product do
    name { Faker::DcComics.hero }
    price { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    sku { Faker::Invoice.reference }
    stock { Faker::Number.between(from: 1, to: 1000) }
  end
end
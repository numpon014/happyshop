# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Category.create(name: "Skincare", :parent => nil) do |category|
#   Category.create(name: 'Masks and Treatments', parent: category)
#   Category.create(name: 'Cleanser and Exfoliator', parent: category)
# end

require 'faker'

Product.delete_all
Category.delete_all

category_coffee = Category.create({name: 'Coffee'})
category_movie_fantasy = Category.create({name: 'Movie - Fantasy'})
category_movie_action = Category.create({name: 'Movie - Action'})
category_movie_sci_fi = Category.create({name: 'Movie - Sci Fi'})
category_beer = Category.create({name: 'Beer'})

30.times do
  Product.create({
    name: Faker::Coffee.blend_name,
    price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    sku: Faker::Invoice.reference,
    stock: Faker::Number.between(from: 1, to: 1000),
    description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
    categories: [ category_coffee ]
   })
end

30.times do
  Product.create({
    name: Faker::Beer.brand,
    price: Faker::Number.decimal(l_digits: 3, r_digits: 2),
    sku: Faker::Invoice.reference,
    stock: Faker::Number.between(from: 1, to: 1000),
    description: Faker::Lorem.paragraphs,
    categories: [ category_beer ]
   })
end

15.times do
  Product.create({
     name: Faker::Movies::StarWars.character,
     price: Faker::Number.decimal(l_digits: 4, r_digits: 2),
     sku: Faker::Invoice.reference,
     stock: Faker::Number.between(from: 1, to: 1000),
     description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
     categories: [category_movie_sci_fi, category_movie_action]
 })
end

15.times do
  Product.create({
       name: Faker::Movies::Hobbit.character ,
       price: Faker::Number.decimal(l_digits: 4, r_digits: 2),
       sku: Faker::Invoice.reference,
       stock: Faker::Number.between(from: 1, to: 1000),
       description: Faker::Lorem.paragraph(sentence_count: 2, supplemental: false, random_sentences_to_add: 4),
       categories: [category_movie_fantasy, category_movie_action]
   })
end

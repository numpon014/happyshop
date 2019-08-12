# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

Category.delete_all
Category.create([{name: 'Masks and Treatments'}, { name: 'Cleanser and Exfoliator'}])

# Category.create(name: "Skincare", :parent => nil) do |category|
#   Category.create(name: 'Masks and Treatments', parent: category)
#   Category.create(name: 'Cleanser and Exfoliator', parent: category)
# end
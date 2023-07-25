# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
puts "Seeding data to the database ...."

#AdminUser.create!(email: 'admin@example.com', password: 'password', password_confirmation: 'password') if Rails.env.development?

Utente.destroy_all 

10.times do
    @utente = Utente.create!(
        username: Faker::Internet.unique.username(specifier: 10),
        nome: Faker::Name.unique.name,
        cognome: Faker::Name.unique.last_name,
        password: Faker::Internet.password(min_length: 8),
        mail: Faker::Internet.unique.email
        ) 
    end

puts "Seeding operation complete !"
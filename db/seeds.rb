# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

require 'faker'
puts "Seeding data to the database ...."





def random_stato
    stati = ['aperto', 'chiuso', 'completato'].shuffle
    stati.first
end

10.times do

    @projects = Project.create!(
            info_leader: Faker::Lorem.paragraphs,
            dimensione: Faker::Number.number,
            descrizione:Faker::Lorem.paragraphs,
            stato: random_stato
        )
    end

puts "Seeding operation complete !"


# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Pense bien sûr à faire un petit seed qui va :

# Détruire ta base actuelle
# Créer 20 utilisateurs
# Créer 10 villes
# Créer 50 listings
# Pour chaque listing
# Créer 5 réservations dans le passé
# Créer 5 réservations dans le futur

require 'faker'

nb_city = 50
nb_user = 500
nb_listing = 200
nb_resa = 300
nb_guest = 500
cities = []
users = []
listings = []
resas = []
guests = []
#seeding cities
nb_city.times do |x|
  city = City.create(
    name: Faker::Address.city,
    zip_code: 75013)
  cities << city
  puts "Seeding city ##{x+1}"
end
#seeding users
nb_user.times do |x|
  user = User.create(
      email: Faker::Internet.email,
      phone_number: '06'+Faker::PhoneNumber.subscriber_number(length: 8),
      description: Faker::Lorem.paragraph)
  users << user
  puts "Seeding User ##{x+1}"
end
#seeding listings
nb_listing.times do |x|
  listing = Listing.create(
      available_beds: rand(1..10),
      price: rand(10..300),
      description: Faker::Lorem.paragraph,
      has_wifi: [true, false].sample,
      welcome_message: Faker::Lorem.paragraph,
      city_id: cities[rand(0..nb_city-1)].id,
      admin_id: users[rand(0..nb_user-1)].id)
  listings << listing
  puts "Seeding Listing ##{x+1}"
end
#seeding resas between those dates
t1 = Time.parse("2018-10-23 14:40:34")
t2 = Time.parse("2021-01-01 00:00:00")
nb_resa.times do |x|
  start = rand(t1..t2)
  resa = Reservation.create(
      start_date: start,
      end_date: rand(start..t2),
      listing_id: listings[rand(0..nb_listing-1)].id)
  resas << resa
  puts "Seeding Reservations ##{x+1}"
end

#seeding guests
nb_guest.times do |x|
  guest = UserReservation.create(
      guest_id: users[rand(0..nb_user-1)].id,
      reservation_id: resas[rand(0..nb_resa-1)].id)
  guests << guest
  puts "Seeding Guests ##{x+1}"
end






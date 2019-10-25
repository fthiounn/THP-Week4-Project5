class User < ApplicationRecord
  has_many :admins, foreign_key: 'admin_id', class_name: "Listing"
  has_many :guests, foreign_key: 'guest_id', class_name: "UserReservation"
end

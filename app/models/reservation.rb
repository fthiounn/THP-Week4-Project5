class Reservation < ApplicationRecord
  has_many :user_reservations
  belongs_to :listing
end

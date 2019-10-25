class Listing < ApplicationRecord
  belongs_to :admin, class_name: "User"
  belongs_to :city
  has_many :reservations
end

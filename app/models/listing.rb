class Listing < ApplicationRecord
  belongs_to :admin, class_name: "User"
  belongs_to :city
  has_many :reservations  
  validates :available_beds, presence: true, :numericality => { :greater_than => 0 }
  validates :price, presence: true, :numericality => { :greater_than => 0 }
  validates :welcome_message, presence: true
end

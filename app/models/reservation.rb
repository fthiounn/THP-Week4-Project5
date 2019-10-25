class Reservation < ApplicationRecord
  has_many :user_reservations
  belongs_to :listing
  validates :start_date, presence: true 
  validates :end_date, presence: true
  validate :overlaping_reservation?

  def period
    start_date..end_date
  end
  def overlaping_reservation? 

    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
    other_bookings = Reservation.all
    #1. check que end_date>start_date
    #2. Pour chaque reservation existante :
    # - si start_date < self.start_date => end date doit aussi etre


end
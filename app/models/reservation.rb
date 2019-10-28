class Reservation < ApplicationRecord
  has_many :user_reservations
  belongs_to :listing
  validates_presence_of :start_date, :end_date
  validate :overlaping_reservation?

  def period
    Time.at(end_date.to_i) - Time.at(start_date.to_i)
  end
  #NOT WORKING !!!!!!!!!!!!!!!!!
  def overlaping?
    # vérifie dans toutes les réservations du listing s'il y a une réservation qui tombe sur le datetime en entrée
    all_reservations = Reservation.all
    return false if all_reservations.empty?
    all_reservations.each do |resa| 
        return true if (start_date..end_date).overlaps?(resa.start_date..resa.end_date)
    end
    false
  end

  def overlaping_reservation?
    errors.add(:base, 'Timedates overlaps') if overlaping?
  end

end

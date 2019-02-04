class Reservation < ApplicationRecord
  belongs_to :listing
  validates_presence_of :starttime, :endtime
  scope :overlapping, -> (interval){ where("listing_id = ?  AND starttime <= ? AND ? <= endtime", interval.listing_id, interval.endtime, interval.starttime)}
  validate :cannot_overlap_dates
  # before_save :check_for_conflicts
  def cannot_overlap_dates
    overlaps = Reservation.overlapping(self).count
    # byebug
    if (self.id == nil && overlaps != 0 ) || (self.id != nil && overlaps > 1)
      errors.add(:cannot_overlap_dates,"Dates are overlapping with other reservations")
    end
  end
end



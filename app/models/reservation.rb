class Reservation < ApplicationRecord
  belongs_to :listing
  validates_presence_of :starttime, :endtime
  scope :overlapping, -> (interval){ where("listing_id = ?  AND starttime <= ? AND ? <= endtime", interval.listing_id, interval.endtime, interval.starttime)}
  validate :cannot_overlap_dates
  afer_save :create_automation
  # before_save :check_for_conflicts
  def cannot_overlap_dates
    overlaps = Reservation.overlapping(self).count
    # byebug
    if (self.id == nil && overlaps != 0 ) || (self.id != nil && overlaps > 1)
      errors.add(:cannot_overlap_dates,"Dates are overlapping with other reservations")
    end
  end

  def create_automation
    if reservation.listing.automation
        Listing.delay(run_at: self.endtime).turn_off_lights(self.reservation.listing_id)
    end
  end
end



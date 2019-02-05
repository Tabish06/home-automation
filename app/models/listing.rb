class Listing < ApplicationRecord
  has_many :reservations
  belongs_to :user
  has_many :devices


  def self.turn_off_lights(id)
    if listing = Listing.find_by_id(id)
    end
  end
end

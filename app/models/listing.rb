class Listing < ApplicationRecord
  has_many :reservations
  belongs_to :user
  has_and_belongs_to_many :devices
end

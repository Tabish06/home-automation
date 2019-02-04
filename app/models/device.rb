class Device < ApplicationRecord
    belongs_to :device_type
    belongs_to :user
    scope :valid_devices, -> {where(listing_id: nil)}
    def to_s
        self.name
    end
end

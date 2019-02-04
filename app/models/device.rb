class Device < ApplicationRecord
	has_and_belongs_to_many :listings
	def to_s
		self.name
	end
end

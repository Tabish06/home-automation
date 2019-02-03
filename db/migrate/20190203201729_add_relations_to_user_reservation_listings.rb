class AddRelationsToUserReservationListings < ActiveRecord::Migration[5.2]
  def change
    add_reference :listings, :user
    add_reference :reservations,:listing
  end
end

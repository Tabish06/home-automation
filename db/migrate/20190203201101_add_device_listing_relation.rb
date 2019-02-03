class AddDeviceListingRelation < ActiveRecord::Migration[5.2]
  def change

    create_table :devices_listings, id: false do |t|
      t.belongs_to :device, index: true
      t.belongs_to :listing, index: true
    end
  end
end

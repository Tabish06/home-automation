class AddDeviceListingTypeRelations < ActiveRecord::Migration[5.2]
  def change
  	add_reference :devices,:listing
  	drop_table :devices_listings
  	create_table :device_types do |t|
      t.string :name
      t.timestamps
    end
    add_reference :devices,:device_type
  end
end

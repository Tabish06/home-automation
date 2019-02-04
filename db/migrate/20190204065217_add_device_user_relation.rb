class AddDeviceUserRelation < ActiveRecord::Migration[5.2]
  def change
  	add_reference :devices,:user
  end
end

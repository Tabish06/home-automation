class CreateReservations < ActiveRecord::Migration[5.2]
  def change
    create_table :reservations do |t|
      t.datetime :starttime
      t.datetime :endtime

      t.timestamps
    end
  end
end

class CreateListings < ActiveRecord::Migration[5.2]
  def change
    create_table :listings do |t|
      t.string :address
      t.boolean :automation_service

      t.timestamps
    end
  end
end

class CreateDevices < ActiveRecord::Migration[5.2]
  def change
    create_table :devices do |t|
      t.string :name
      t.boolean :switch
      t.string :smart_id
      t.timestamps
    end
  end
end

class AddClientIdSecretTokenToListing < ActiveRecord::Migration[5.2]
  def change
    add_column :listings,:client_id,:string
    add_column :listings,:client_secret,:string
    add_column :listings,:token,:string
  end
end

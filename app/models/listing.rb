class Listing < ApplicationRecord
  has_many :reservations
  belongs_to :user
  has_many :devices


  def self.turn_off_lights(id)
    if listing = Listing.find_by_id(id)
      if listing.token != nil && listing.automation_service == true
        uri = get_uri(listing.token)
        response = HTTParty.put(uri+'/switches/off', headers: {"Authorization" => "Bearer #{listing.token}"})
      end
    end
  end

  def self.get_status_of_lights(token)
    uri = get_uri(token)
    response = HTTParty.get(uri+'/switches', headers: {"Authorization" => "Bearer #{token}"})
    json = JSON.parse(response.body)
    return json
  end

  private
  def self.get_uri(token)
    endpoints_uri = 'https://graph.api.smartthings.com/api/smartapps/endpoints'
    response = HTTParty.get(endpoints_uri, headers: {"Authorization" => "Bearer #{token}"})
    json = JSON.parse(response.body)
    return json[0]['uri']
  end
end

json.extract! reservation, :id, :starttime, :endtime, :created_at, :updated_at
json.url reservation_url(reservation, format: :json)

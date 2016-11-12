json.array!(@graphics) do |graphic|
  json.extract! graphic, :id, :description, :quantity, :height, :width, :event_at, :note, :location, :hardware_type, :hardware_price, :rush
  json.url graphic_url(graphic, format: :json)
end

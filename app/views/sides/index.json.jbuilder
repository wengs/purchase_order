json.array!(@sides) do |side|
  json.extract! side, :id, :name
  json.url side_url(side, format: :json)
end

json.array!(@regions) do |region|
  json.extract! region, :id, :prefix, :name
  json.url region_url(region, format: :json)
end

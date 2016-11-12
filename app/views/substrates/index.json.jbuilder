json.array!(@substrates) do |substrate|
  json.extract! substrate, :id, :name, :client_cost, :our_cost
  json.url substrate_url(substrate, format: :json)
end

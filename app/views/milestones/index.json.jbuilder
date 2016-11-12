json.array!(@milestones) do |milestone|
  json.extract! milestone, :id, :name
  json.url milestone_url(milestone, format: :json)
end

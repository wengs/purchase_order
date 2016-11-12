json.(Activity.order("created_at").last(10)) do |log|
  json.id log.id
  json.name log.name
  json.date log.created_at.localtime.strftime('%m/%d/%Y %I:%M %p')
end
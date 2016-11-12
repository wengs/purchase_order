module ApplicationHelper

  def format_date_time(timestamp)
    return timestamp if timestamp.is_a?(String)
    timestamp.strftime('%m/%d/%Y %I:%M %p')
  end
end

module ApplicationHelper

  def format_timestamp(timestamp)
    return nil if timestamp.nil?
    Time.at(timestamp).to_datetime.strftime('%m-%d %R')
  end

  def humanize_timestamp(timestamp, timeonly = false)
    date = Time.at(timestamp).to_date
    if date == Date.today
      'Today'
    elsif date == Date.yesterday
      'Yesterday'
    elsif (date > Date.today - 7) && (date < Date.yesterday)
      # n day(s) ago
      "#{(date - Date.today).to_i / 1.day} Day(s) ago"
    else
      date.strftime('%m/%d')
    end
  end

end

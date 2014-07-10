module ApplicationHelper

  def display_datetime(dt)
    dt.strftime("%m/%d/%Y %Z")
  end

  def fix_url(str)
    str.starts_with?('http://') ? str : "http://#{str}"
  end

end

module EventsHelper
  def format_timestamp(date)
    d = DateTime.parse(date)
    d.strftime("%l:%M%P %d %B %Y")
  end
  
  def format_date_without_time_for_urls(date)
    d = DateTime.parse(date)
    d.strftime("%Y-%m-%d")
  end
  
  def format_date_without_time(date)
    d = DateTime.parse(date)
    d.strftime("%d %B %Y")
  end
  
  def format_date_as_timestamp(date)
    d = DateTime.parse(date)
    d.strftime("%H:%M:%S%p")
  end
  
  def network_title(sid)
    Network.find_by_web_key(sid).name
  end
end

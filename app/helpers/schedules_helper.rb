module SchedulesHelper
  def format_date(date)
    d = DateTime.parse(date)
    d.strftime("%Y-%m-%d-%H:%M")
  end
  
  def format_previous_day(date)
    d = DateTime.parse(date)
    d -= 1
    
    d.strftime("%Y-%m-%d")
  end
  
  def format_next_day(date)
    d = DateTime.parse(date)
    d += 1
    
    d.strftime("%Y-%m-%d")
  end
  
  def friendly_format_date_param(date)
    d = DateTime.parse(date)
    d.strftime("%A %B %e %Y")
  end

end
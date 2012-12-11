module NetworksHelper
  def todays_date
    d = DateTime.now
    d.strftime("%Y-%m-%d")
  end
end

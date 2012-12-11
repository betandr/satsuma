require 'feed_loader'

class Schedule < ActiveRecord::Base
  belongs_to :network
  
  def broadcasts_for_date(period)
    feed = FeedLoader.new.load_feed("http://www.bbc.co.uk#{feed_url}/#{period.gsub('-', '/')}.json")
    broadcasts = []
    feed['schedule']['day']['broadcasts'].each do |broadcast|      
      # If no programme/programme node, pick the higher-level title.
      title = broadcast['programme']['programme'].nil? ? broadcast['programme']['title'] : broadcast['programme']['programme']['title']

      broadcasts << { 
        :start => broadcast['start'], 
        :end => broadcast['end'], 
        :pid => broadcast['programme']['pid'], 
        :title => title, 
        :short_synposis => broadcast['programme']['short_synopsis']
      }
    end
    
    broadcasts
  end

end

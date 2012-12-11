require 'rexml/document'

class Network < ActiveRecord::Base
  has_one :schedule
  
  
  def network_events_for_start_timestamp_and_end_timestamp(start_timestamp, end_timestamp)
    
    start_time = DateTime.parse(start_timestamp).strftime("%Y-%m-%d-%H-%M-%S")
    end_time = DateTime.parse(end_timestamp).strftime("%Y-%m-%d-%H-%M-%S")

    feed = FeedLoader.new.load_feed("https://api.live.bbc.co.uk/realtime/services/#{sid}/messages.json?start=#{start_time}&end=#{end_time}", {:use_cert => true})
    
    events = []
    feed['messages'].each do |event| 
      if event['type'] == 'now_playing'
        events << { 
          :realtime_id => event['realtime_id'], 
          :type => event['type'], 
          :start => event['content']['message']['start'],
          :end => event['content']['message']['end'],
          :artist => event['content']['message']['artist'],
          :title => event['content']['message']['title'],
         }
      elsif  event['type'] == 'text'
        events << { 
          :realtime_id => event['realtime_id'], 
          :type => event['type'], 
          :content => event['content']['message']['content'],
          :start => event['content']['message']['start'],
          :end => event['content']['message']['end']
         }
      else
        events << { 
          :realtime_id => event['realtime_id'], 
          :type => event['type'], 
          :start => event['content']['message']['start'],
          :end => event['content']['message']['end']
         }
      end

    end
    
    events
  end
end

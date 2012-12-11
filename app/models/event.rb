class Event < ActiveRecord::Base
  
  def self.load_by_realtime_id(realtime_id)
    feed = FeedLoader.new.load_feed("https://api.live.bbc.co.uk/realtime/messages/#{realtime_id}", {:use_cert => true})

    event = Event.new
    event.realtime_id = realtime_id
    event.sid = feed['message']['service']['sid']
    event.message_type = feed['message_type']
    event.start = DateTime.parse feed['message']['start']
    event.end = DateTime.parse feed['message']['end']
    event.artist = feed['message']['artist']
    event.title = feed['message']['title']
    event.content = feed['message']['content']    
    event.musicbrainz_id = feed['message']['musicbrainz_artist']['id'] unless feed['message']['musicbrainz_artist'].nil?
    
    event.save!
    
    event
  end
end

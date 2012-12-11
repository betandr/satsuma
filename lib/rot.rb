class Rot
  TEMPORARY_FILE = "/tmp/clip-temp-#{$$}.wav"
  
  ROT_ARCHIVE_PATH = {
    'bbc_1xtra' => '/Volumes/radio-archive/LO1/1Xtra/RoTs/%Y/Week_{week_number}_({week_start}_{week_end})/%d%m%y/1X-1X_ROT_%d-%b-%Y_%H_{minutes}_0{seconds}.wav',
    'bbc_radio_one' => '/Volumes/radio-archive/LO1/Radio1/RoTs/%Y/Week_{week_number}_({week_start}_{week_end})/%d%m%y/R1-ROT_Radio_1_%d-%b-%Y_%H_{minutes}_0{seconds}.wav',
    'bbc_radio_two' => '/Volumes/radio-archive/LO2/Radio2/RoTs/%Y/Week_{week_number}_({week_start}_{week_end})/%d%m%y/R2-ROT_Radio_2_from_%d.%m.%Y_at_%H_{minutes}_0{seconds}.wav',
    'bbc_6music' => '/Volumes/radio-archive/LO2/6M/RoTs/%Y/Week_{week_number}_({week_start}_{week_end})/%d%m%y/6M-ROT_6music_from_%d.%m.%Y_at_%H_{minutes}_0{seconds}.wav'
  }
  
  ROT_PATH = {
    'bbc_1xtra' => '/Volumes/radio-archive/LO1/1Xtra/RoTs/1X-1X_ROT_%d-%b-%Y_%H_{minutes}_0{seconds}.wav',
    'bbc_radio_one' => '/Volumes/radio-archive/LO1/Radio1/RoTs/R1-ROT_Radio_1_%d-%b-%Y_%H_{minutes}_0{seconds}.wav',
    'bbc_radio_two' => '/Volumes/radio-archive/LO2/Radio2/RoTs/R2-ROT_Radio_2_from_%d.%m.%Y_at_%H_{minutes}_0{seconds}.wav',
    'bbc_6music' => '/Volumes/radio-archive/LO2/6M/RoTs/6M-ROT_6music_from_%d.%m.%Y_at_%H_{minutes}_0{seconds}.wav'
  }
  
  def get_start_offset_from_rot(event, options = {})
    rot_offset = options[:rot_offset].nil? ? 0 : options[:rot_offset].to_i
    "#{"%02d" % (event.start.min - rot_offset)}:#{"%02d" % event.start.sec}"
  end
  
  def get_clip_length_from_rot(event)
    mins = (event.end - event.start).to_i / 60
    secs = (event.end - event.start).to_i % 60
    
    "#{"%02d" % mins}:#{"%02d" % secs}"
  end
  
  def rot_for_event(event)
    p "Getting event id: #{event.realtime_id}"
    clip_path = "/Users/anderb08/Projects/satsuma/public/clips/#{event.message_type}_#{event.realtime_id}.mp3"
    web_path = "/clips/#{event.message_type}_#{event.realtime_id}.mp3"

    # If file has already been loaded, then just return URL
    if FileTest.exists? clip_path
      p "Event clip already exists, returning URL"
      return web_path
    end

    rot_path = get_rot_path(event)
    
    p "Creating clip of RoT at #{get_start_offset_from_rot(event)} for #{get_clip_length_from_rot(event)} from #{rot_path} to #{TEMPORARY_FILE}"    
    system('sox', '-twav', rot_path, TEMPORARY_FILE,
      'trim', calculate_start_offset(rot_path, event), get_clip_length_from_rot(event)
    ) or raise "Failed to create clip"
    
    p "Encoding clip of RoT to MP3 to #{clip_path}"
    system('lame',
      '--r3mix', 
      '-q0', 
      '--id3v2-only', 
      '--tt', event.title,
      '--ta', event.artist,
      TEMPORARY_FILE, clip_path
    ) or raise "Failed to re-encode clip"
    
    p "Returning #{web_path}"
    web_path
  end
  
  private
  
    def calculate_start_offset(rot_path, event)
      half_hour_rot_format = /_30_0[0-9]\.wav$/
      if half_hour_rot_format.match rot_path
        start_offset = get_start_offset_from_rot(event, :rot_offset => 30)
      else
        start_offset = get_start_offset_from_rot(event)
      end
    end
    
    def get_rot_path(event)    
      date = DateTime.parse(event.start.to_s)
      
      # Today's RoTs are in the root folder, previous days in the archive
      if date.today?
        path = date.strftime(ROT_PATH[event.sid])
        
      else
        path = date.strftime(ROT_ARCHIVE_PATH[event.sid])

        # Weird case with Saturday being start of the week
        if date.wday == 6
          week_number = date.strftime("%U").to_i + 1
          week_start = date.day
          week_end = week_start + 6
        else
          week_start = date - (date.wday + 1)
          week_number = date.strftime("%U")
          week_end = week_start + 6
        end

        # Week_40_(290912_051012)

        path.gsub!("{week_start}", week_start.strftime("%d%m%y")).gsub!("{week_end}", week_end.strftime("%d%m%y"))
        path.gsub!("{week_number}", week_number.to_s)
        
      end
      
      # As RoTs can have different start seconds
      (0..9).each do |seconds|
        
        if event.start.min > 29
          temp_path = path.gsub("{seconds}", seconds.to_s).gsub("{minutes}", "30")

          p "Checking for: #{temp_path}"
          if FileTest.exists? temp_path
            return temp_path
          end
        end
        
        temp_path = path.gsub("{seconds}", seconds.to_s).gsub("{minutes}", "00")
      
        p "Checking for: #{temp_path}"
        if FileTest.exists? temp_path
          return temp_path
        end
      end
    
      raise "Could not find RoT"
    end
end
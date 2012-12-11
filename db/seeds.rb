# Seed data

Network.create(:sid => 'bbc_radio_one', :name => 'BBC Radio 1', :web_key => 'radio1')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_one').id, :feed_url => '/radio1/programmes/schedules/england')

Network.create(:sid => 'bbc_radio_two', :name => 'BBC Radio 2', :web_key => 'radio2')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_two').id, :feed_url => '/radio2/programmes/schedules')

Network.create(:sid => 'bbc_radio_three', :name => 'BBC Radio 3', :web_key => 'radio3')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_three').id, :feed_url => '/radio3/programmes/schedules')

Network.create(:sid => 'bbc_radio_four', :name => 'BBC Radio 4', :web_key => 'radio4')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_four').id, :feed_url => '/radio4/programmes/schedules/fm')

Network.create(:sid => 'bbc_radio_five_live', :name => 'BBC Radio 5 Live', :web_key => 'radio5live')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_five_live').id, :feed_url => '/5live/programmes/schedules')

Network.create(:sid => 'bbc_6music', :name => 'BBC 6 Music', :web_key => '6music')
Schedule.create(:network_id => Network.find_by_sid('bbc_6music').id, :feed_url => '/6music/programmes/schedules')

Network.create(:sid => 'bbc_radio_four_extra', :name => 'BBC Radio 4 Extra', :web_key => 'radio4extra')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_four_extra').id, :feed_url => '/radio4extra/programmes/schedules')

Network.create(:sid => 'bbc_radio_five_live_sports_extra', :name => 'BBC Radio 5 Live Sports Extra', :web_key => '5livesportsextra')
Schedule.create(:network_id => Network.find_by_sid('bbc_radio_five_live_sports_extra').id, :feed_url => '/5livesportsextra/programmes/schedules')

Network.create(:sid => 'bbc_1xtra', :name => 'BBC 1Xtra', :web_key => '1xtra')
Schedule.create(:network_id => Network.find_by_sid('bbc_1xtra').id, :feed_url => '/1xtra/programmes/schedules')

Network.create(:sid => 'bbc_asian_network', :name => 'BBC Asian Network', :web_key => 'asiannetwork')
Schedule.create(:network_id => Network.find_by_sid('bbc_asian_network').id, :feed_url => '/asiannetwork/programmes/schedules')

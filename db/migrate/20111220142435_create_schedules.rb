class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :feed_url
      t.integer :network_id

      t.timestamps
    end
  end
end

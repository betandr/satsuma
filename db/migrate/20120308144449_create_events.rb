class CreateEvents < ActiveRecord::Migration
  def change
    create_table :events do |t|
      t.integer :realtime_id
      t.string :message_type
      t.datetime :start
      t.datetime :end
      t.string :artist
      t.string :title
      t.text :content

      t.timestamps
    end
  end
end

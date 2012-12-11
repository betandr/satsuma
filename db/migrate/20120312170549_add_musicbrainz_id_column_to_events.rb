class AddMusicbrainzIdColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :musicbrainz_id, :string
  end
end

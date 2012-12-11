class AddPlayedOnTitleToEvents < ActiveRecord::Migration
  def change
    add_column :events, :played_on_title, :string
  end
end

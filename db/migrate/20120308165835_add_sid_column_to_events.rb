class AddSidColumnToEvents < ActiveRecord::Migration
  def change
    add_column :events, :sid, :string
  end
end

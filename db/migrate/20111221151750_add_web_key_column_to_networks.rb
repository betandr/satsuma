class AddWebKeyColumnToNetworks < ActiveRecord::Migration
  def change
    add_column :networks, :web_key, :string
  end
end

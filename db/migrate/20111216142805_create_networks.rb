class CreateNetworks < ActiveRecord::Migration
  def change
    create_table :networks do |t|
      t.string :sid

      t.timestamps
    end
  end
end

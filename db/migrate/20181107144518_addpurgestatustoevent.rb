class Addpurgestatustoevent < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :purge_status, :integer
  end
end

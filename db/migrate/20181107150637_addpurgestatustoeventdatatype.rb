class Addpurgestatustoeventdatatype < ActiveRecord::Migration[5.1]
  def change
    change_column :events, :purge_status, :boolean, using: 'purge_status::boolean'
  end
end

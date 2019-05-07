class RmoveCompanyplugin < ActiveRecord::Migration[5.1]
  def change
  	remove_column :companies, :plugin_id
  end
end

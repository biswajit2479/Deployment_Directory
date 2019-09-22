class RenamePlugin < ActiveRecord::Migration[5.1]
  def change
  	rename_column :companies, :plugin, :plugin_id
    change_column :companies, :plugin_id,'integer USING CAST(plugin_id AS integer)'
  end
end

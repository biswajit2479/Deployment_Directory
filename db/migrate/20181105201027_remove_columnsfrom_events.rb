class RemoveColumnsfromEvents < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :plugin_deployment
    remove_column :events, :g_cal
    remove_column :events, :csm_name
    remove_column :events, :cluster

  end
end

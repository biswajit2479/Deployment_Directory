class RemoveColumnsfromEvents2 < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :plugin_name
  end
end

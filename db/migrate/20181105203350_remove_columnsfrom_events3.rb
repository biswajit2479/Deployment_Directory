class RemoveColumnsfromEvents3 < ActiveRecord::Migration[5.1]
  def change
    remove_column :events, :event_type
  end
end

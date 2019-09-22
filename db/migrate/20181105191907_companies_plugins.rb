class CompaniesPlugins < ActiveRecord::Migration[5.1]
  def change
    create_table :events_plugins, id: false do |t|
      t.belongs_to :event, index: true
      t.belongs_to :plugin, index: true
    end
  end
end

class AddCompanyplugin < ActiveRecord::Migration[5.1]
  def change
  	create_table :companies_plugins, id: false do |t|
      t.belongs_to :company, index: true
      t.belongs_to :plugin, index: true
  end
  end
end

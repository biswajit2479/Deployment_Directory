class Renameprovidertable < ActiveRecord::Migration[5.1]
  def change
  	rename_table :providers, :deployments
  	rename_column :deployments, :deployment, :name
  end
end

class RemoveDeploymentFromCompany < ActiveRecord::Migration[5.1]
  def change
  	remove_column :companies, :deployment
  end
end

class AddClusterIdToCompany < ActiveRecord::Migration[5.1]
  def change
  	add_column :companies, :cluster_id, :integer
  end
end

class AddCompanyDeployment < ActiveRecord::Migration[5.1]
  def change
  	create_table :companies_deployments, id: false do |t|
      t.belongs_to :company, index: true
      t.belongs_to :deployment, index: true
    end
  end
end

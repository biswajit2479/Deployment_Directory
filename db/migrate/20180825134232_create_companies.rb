class CreateCompanies < ActiveRecord::Migration[5.1]
  def change
    create_table :companies do |t|
      t.string :name
      t.string :system_name
      t.string :deployment
      t.string :cluster
      t.string :plugin

      t.timestamps
    end
  end
end

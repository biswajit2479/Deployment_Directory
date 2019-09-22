class AddcompanyId < ActiveRecord::Migration[5.1]
  def change
    add_column :events, :company_id, :integer
    remove_column :events, :company_name
    remove_column :events, :company_system_name
  end
end

class RemoveStatusFromCompany < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :status_id
  end
end

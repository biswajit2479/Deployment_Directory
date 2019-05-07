class AddUserinfoToCompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :last_updated_by, :string
  end
end

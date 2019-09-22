class RemoveUpdatebyfromCompany < ActiveRecord::Migration[5.1]
  def change
    remove_column :companies, :last_updated_by, :string
  end
end

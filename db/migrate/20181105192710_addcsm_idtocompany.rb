class AddcsmIdtocompany < ActiveRecord::Migration[5.1]
  def change
    add_column :companies, :csm_id, :integer
  end
end

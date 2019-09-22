class ChangeColumncsmId < ActiveRecord::Migration[5.1]
  def change
    rename_column :companies, :csm_id, :csm_info_id
  end
end

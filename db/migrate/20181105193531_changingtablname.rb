class Changingtablname < ActiveRecord::Migration[5.1]
  def change
    drop_table :csm_info
  end
end

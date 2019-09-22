class Csminfo < ActiveRecord::Migration[5.1]
  def change
    create_table :csm_info do |t|
      t.string :email
      t.string :name
    end
  end
end

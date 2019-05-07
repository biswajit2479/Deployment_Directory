class CreateCsmInfos < ActiveRecord::Migration[5.1]
  def change
    create_table :csm_infos do |t|
      t.string :email
      t.string :name

      t.timestamps
    end
  end
end

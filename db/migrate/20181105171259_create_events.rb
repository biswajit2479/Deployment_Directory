class CreateEvents < ActiveRecord::Migration[5.1]
  def change
    create_table :events do |t|
      t.string :company_name
      t.string :company_system_name
      t.string :event_name
      t.string :event_system_name
      t.string :event_type
      t.date :start_date
      t.date :end_date
      t.date :creation_date
      t.date :purge_date
      t.string :cluster
      t.string :plugin_deployment
      t.string :plugin_name
      t.string :g_cal
      t.string :csm_name
      t.string :card_no
      t.string :link

      t.timestamps
    end
  end
end

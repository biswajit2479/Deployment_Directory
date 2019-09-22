class AddPluginsAsPloymorphic < ActiveRecord::Migration[5.1]
  def change
  	drop_table :plugins
  	
    create_table :plugins do |t|
      t.string  :name
      t.integer :entity_id
      t.string  :entity_type
      t.timestamps
    end

    add_index :plugins, [:entity_type, :entity_id]
  end
end
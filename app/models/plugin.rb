class Plugin < ApplicationRecord
	PLUGINS = ["guided_tour","adapter_ui","Cis.ruby"]
	belongs_to :entity, polymorphic: true
end
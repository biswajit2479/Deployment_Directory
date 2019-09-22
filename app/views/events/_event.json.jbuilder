json.extract! event, :id, :company_name, :company_system_name, :event_name, :event_system_name, :event_type, :start_date, :end_date, :creation_date, :purge_date, :cluster, :plugin_deployment, :plugin_name, :g_cal, :csm_name, :card_no, :link, :created_at, :updated_at
json.url event_url(event, format: :json)

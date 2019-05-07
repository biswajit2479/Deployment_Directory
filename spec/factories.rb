FactoryBot.define do
	factory :company do
		name {|n| "company_#{n}"}
		system_name {|n| "company_#{n}"}
		deployments {[FactoryBot.create(:deployment)]}
		cluster { FactoryBot.create(:cluster) }
		csm_info { FactoryBot.create(:csm_info)}
	end

	factory :deployment do
		name {|n| "deployment_#{n}"}
	end

	factory :cluster do
      name {|n| "cluster_#{n}"}
   	end

   	factory :csm_info do
   		email {|n| "email_#{n}"}
   		name {|n| "name_#{n}"}
   	end

   	factory :plugin do
		name {|n| "plugin_#{n}"}
		after(:create) do |plugin|
  			create(:company, entity: company)
		end
   	end

   	factory :event do 
   		event_name {|n| "event#{n}"}
   		event_system_name {|n| "event#{n}"}
   		start_date {"2020-10-09".to_date}
   		end_date {"2020-10-12".to_date}
   		creation_date {DateTime.now}
   		purge_date {DateTime.now+14.days}
   		card_no { "PS-123"}
   		company {FactoryBot.create(:company)}
   		event_type { FactoryBot.create(:event_type)}
   	end

   	factory :event_type  do
   		event_type {|n| "event type#{n}"}
   	end
end

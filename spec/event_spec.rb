require 'rails_helper'

RSpec.describe Event, type: :model do 
	describe 'validations' do
		it { is_expected.to validate_presence_of(:event_system_name) }
		it { is_expected.to validate_presence_of(:event_name) }
		it { is_expected.to validate_presence_of(:start_date) }
		it { is_expected.to validate_presence_of(:end_date) }
		it { is_expected.to validate_presence_of(:card_no) }
	end

	describe 'plugin_names' do
		event = FactoryBot.create(:event)
		it 'should return plugin names' do 
			expect(event.plugin_names).to eql(event.plugins.pluck(:name).uniq)
		end
	end

	describe 'search' do

		context 'when there is no event in DB' do
	      it "should return no event" do
	        expect(Event.search("qwertyuiop")).to be_empty
	      end
	    end

	    context 'when there is event' do
	     before {
	       @event = FactoryBot.create(:event)
	     }

	      context 'when search term matches' do
	       it 'should return the matched company' do
	         expect(Event.search(@event.event_system_name).first).to eql @event
	       end
	      end

	      context 'when search term doesn\'t matches' do
	       	it 'should return no event' do
	        	expect(Event.search(@event.event_system_name)).to_not eq @event
	       	end
	    	end
		end
  	end

	describe 'cluster' do 
	  	it 'should return the cluster name' do
	  		event = FactoryBot.create(:event)
	  		expect(event.cluster).to eql(event.company.cluster)
	  	end
	end

	describe 'purge' do 
		it 'should updated the purge status' do
			event=FactoryBot.create(:event)
			event.purge
			event.reload
			expect(event.purge_status).to be_truthy
		end
	end

	describe 'unpurge' do 
		it 'should update the purge status to false' do
			event = FactoryBot.create(:event)
			event.unpurge
			event.reload
			expect(event.purge_status).to be_falsey
		end
	end

	describe 'purge_passive' do
		it 'should update the purge status for multiple events' do
			event = FactoryBot.create(:event)
			date = "2020-10-29".to_date
			Event.passive(date).update_all(purge_status: true)
			expect(Event.where("purge_date" < "date").each {|e| e.purge_status}).to be_truthy
		end
	end
end
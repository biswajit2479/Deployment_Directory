require 'rails_helper'

RSpec.describe Company, type: :model do
  describe "validations" do
   it { is_expected.to validate_presence_of(:name) }
   it { is_expected.to validate_presence_of(:system_name) }
   it { is_expected.to validate_presence_of(:deployments) }
   it { is_expected.to validate_presence_of(:csm_info_id) }
  end

  describe ".search" do
    context 'when there is no company in DB' do
      it "should return no company" do
        expect(Company.search("qwertyuiop")).to be_empty
      end
    end

    context 'when there is company' do
     before {
       @company = FactoryBot.create(:company)
     }

      context 'when search term matches' do
       it 'should return the matched company' do
         expect(Company.search(@company.system_name).first).to eql @company
       end
      end

      context 'when search term doesn\'t matches' do
       it 'should return no company' do
         expect(Company.search(@company.system_name)).to_not eq @company
        end
      end
    end
  end

  describe 'name_with_cluster' do
    it 'should return the company name with the cluster' do 
      company = FactoryBot.create(:company)
      expect(company.name_with_cluster).to eql("#{company.name}--#{company.cluster.name}")
    end
  end

  describe 'deployment_names' do
    it 'should return the name of the deployments' do 
      company = create(:company)
      expect(company.deployment_names).to eql(company.deployments.pluck(:name).uniq)
    end
  end

  describe 'plugin_names' do
    it 'should return the plugin name' do 
      company = create(:company)
      expect(company.plugin_names).to eql((company.plugins.pluck(:name)).uniq)
    end
  end
end

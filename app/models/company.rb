class Company < ApplicationRecord
	
	before_save :system_name_trim
	validates :name, :system_name, :deployments,:csm_info_id, presence: true
	validates :system_name, :uniqueness => {:scope => :cluster_id}
	
	has_and_belongs_to_many :deployments
	belongs_to :cluster
	belongs_to :csm_info
	has_many :plugins, as: :entity
	has_many :events, :dependent => :delete_all
	scope :cluster, -> (cluster_id) { where cluster_id: cluster_id }

	class << self
		def to_csv(companies,options = {})
  		desired_columns = ["name", "system_name","deployments" "cluster","plugin"]
    	CSV.generate(options) do |csv|
  		csv << column_names
		    companies.each do |company|
	      		csv << product.attributes.values_at(*desired_columns)
    		end
  		end
	  end

		def search(search)
	  	self.where("system_name ILIKE ?","%#{search}%")
		end
	end
  

	def deployment_names
		self.deployments.pluck(:name).uniq
	end

	def plugin_names
		self.plugins.pluck(:name).uniq
	end

	def name_with_cluster
    "#{name}--#{cluster.name}"
  	end

	private

	def system_name_trim
		self.system_name = self.system_name.strip
		self.system_name = self.system_name.downcase
	end

end
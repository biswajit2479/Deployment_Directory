class Event < ApplicationRecord

  before_save :system_name_trim, :update_purge_date, :update_url, :update_purge_status
  validates :event_system_name, :uniqueness => {:scope => [:company_id,:event_type_id]}
  validates :event_name, :event_system_name, :start_date, :end_date, :card_no, :company_id, :event_type_id, presence: true
  scope :passive, -> (date_search) {where("purge_date < ?", "%#{date_search}%")}
  scope :cluster_events, -> (cluster_id) { where(company: Company.cluster(cluster_id))}

  belongs_to :company
  belongs_to :event_type
  has_many :plugins, as: :entity


  def plugin_names
    self.plugins.pluck(:name).uniq
  end

  def self.search(search)
     self.where("event_system_name ILIKE ?", "%#{search}%")
  end

  def cluster
    company.cluster
  end

  def purge
    self.purge_status = true
    self.save
  end

  def unpurge
    self.purge_status = false
    self.save
  end

  def self.purge_passive date
    self.passive(date).update_all(purge_status: true)
  end

  def self.to_csv(events,options = {})
    desired_columns = [ "company_name","company_system_name","name", "system_name","cluster","event_type","start_date","end_date","plugin"]
      CSV.generate(options) do |csv|
    csv << column_names
        events.each do |event|
            csv << product.attributes.values_at(*desired_columns)
        end
      end
  end


  private

  def system_name_trim
    self.event_system_name = self.event_system_name.strip
    self.event_system_name = self.event_system_name.downcase
  end

  def update_purge_date
    self.purge_date = self.end_date + 14.days
  end

  def update_purge_status
    self.purge_status = false if self.purge_status == nil
  end

  def update_url
    if self.company.cluster.name == "staging"
      self.link = "https://#{self.company.system_name}-staging.jifflenow.com/#{self.event_system_name}"
    elsif self.company.cluster.name == "demo"
      self.link = "https://#{self.company.system_name}-staging.jifflenow.com/#{self.event_system_name}"
    else
      self.link = "https://#{self.company.system_name}.jifflenow.com/#{self.event_system_name}"
    end
  end

end

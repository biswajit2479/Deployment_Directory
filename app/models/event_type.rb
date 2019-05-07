class EventType < ApplicationRecord
  has_many :events
  validates :event_type, presence: true
end

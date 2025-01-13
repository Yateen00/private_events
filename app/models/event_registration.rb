class EventRegistration < ApplicationRecord
  belongs_to :attendee, class_name: "User", inverse_of: :event_registrations
  belongs_to :attended_event, class_name: "Event", inverse_of: :event_registrations
  enum status: { invited: 0,  accepted: 1, declined: 2,  registered: 3, cancelled: 4 }
  validates :attendee, :attended_event, presence: true
end

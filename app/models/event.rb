class Event < ApplicationRecord
  belongs_to :creator, class_name: "User", inverse_of: :created_events

  has_many :event_registrations, class_name: "EventRegistration", foreign_key: "attended_event_id", inverse_of: :attended_event
  has_many :attendees, through: :event_registrations, source: :attendee, inverse_of: :attended_events

  validates :creator, :title, :description, :location, :date, presence: true
  validate :date_cannot_be_in_the_past, on: :create

  before_destroy :prevent_deletion_after_end_date

  private

  def date_cannot_be_in_the_past
    if date.present? && date < DateTime.now
      errors.add(:date, "Date can't be in the past")
    end
  end

  def prevent_deletion_after_end_date
    if date.present? && date < DateTime.now
      errors.add(:base, "Cannot delete an event after its end date")
      throw(:abort)
    end
  end
end

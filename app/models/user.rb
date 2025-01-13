class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable
  has_many :created_events, foreign_key: :creator_id, class_name: "Event", inverse_of: :creator

  has_many :event_registrations, foreign_key: :attendee_id, class_name: "EventRegistration", inverse_of: :attendee


  has_many :attended_events, through: :event_registrations, source: :attended_event, inverse_of: :attendees

  validates :name, presence: true
end

class EventRegistrationsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_event

  def create
    @event_registration = @event.event_registrations.build(attendee: current_user)
    if @event_registration.save
      @event_registration.registered!
      redirect_to @event, notice: "You have successfully registered for this event"
    else
      redirect_to @event, alert: "You were unable to register for this event", status: :unprocessable_entity
    end
  end

  def destroy
    @event_registration = @event.event_registrations.find_by(attendee: current_user)
    @event_registration.destroy
    redirect_to @event, notice: "You have successfully unregistered from this event"
  end

  private

  def set_event
    @event = Event.find(params[:event_id])
  end
end

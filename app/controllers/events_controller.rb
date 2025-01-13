class EventsController < ApplicationController
  before_action :authenticate_user!, except: [ :index, :show ]
  def index
    @events = Event.all
  end
  def new
    @event = Event.new
  end
  def show
    @event = Event.find(params[:id])
  end
  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to @event, notice: "Event was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @event = Event.find(params[:id])
  end

  def update
    if @event.update(event_params)
      redirect_to @event, notice: "Event was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @event.destroy
    redirect_to events_url, notice: "Event was successfully destroyed."
  end

  private
  def event_params
    params.require(:event).permit(:date, :description, :location, :title)
  end
end

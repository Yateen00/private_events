module EventHelper
  def event_description(event, caller)
    caller == "show_event" ? event.description : truncate(event.description, length: 100)
  end

  def show_edit_delete_buttons?(caller, current_user, event)
    caller == "show_user" && current_user == event.creator
  end
end

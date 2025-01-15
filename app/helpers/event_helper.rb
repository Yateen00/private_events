module EventHelper
  def event_action_buttons(event, show_admin_links)
    if show_admin_links && current_user == event.creator
      edit_and_delete_buttons(event)
    elsif current_user != event.creator
      if user_signed_in? && event.attendees.include?(current_user)
        cancel_registration_button(event)
      else
        register_button(event)
      end
    end
  end

  private

  def edit_and_delete_buttons(event)
    button_to("Edit", edit_event_path(event), method: :get,
                                              style: "display: inline-block; padding: 10px 20px; border-radius: 50px; background-color: #007bff; color: white; text-decoration: none; text-align: center; margin-right: 10px;") +
      button_to("Delete", event_path(event), method: :delete, data: { confirm: "Are you sure?" },
                                             style: "display: inline-block; padding: 10px 20px; border-radius: 50px; background-color: #ff0000; color: white; text-decoration: none; text-align: center;")
  end

  def cancel_registration_button(event)
    button_to("Cancel Registration",
              event_event_registration_path(event, event.event_registrations.find_by(attendee_id: current_user.id)), method: :delete, style: "display: inline-block; padding: 10px 20px; border-radius: 50px; background-color: #ff0000; color: white; text-decoration: none; text-align: center;")
  end

  def register_button(event)
    button_to("Register", event_event_registrations_path(event), method: :post,
                                                                 style: "display: inline-block; padding: 10px 20px; border-radius: 50px; background-color: #007bff; color: white; text-decoration: none; text-align: center;")
  end
end

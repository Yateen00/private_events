module EventHelper
  def event_action_buttons(event, show_admin_links, in_past)
    return button_tag "Event has ended", type: "button", class: "button button-ended" if in_past

    buttons = ""
    buttons += edit_and_delete_buttons(event) if show_admin_links && current_user == event.creator

    buttons += if user_signed_in? && event.attendees.include?(current_user)
                 cancel_registration_button(event)
               else
                 register_button(event)
               end

    buttons.html_safe
  end

  private

  def edit_and_delete_buttons(event)
    button_to("Edit", edit_event_path(event), method: :get, class: "button button-edit") +
      button_to("Delete", event_path(event), method: :delete, data: { confirm: "Are you sure?" },
                                             class: "button button-delete")
  end

  def cancel_registration_button(event)
    registration = event.event_registrations.find_by(attendee_id: current_user.id)
    return "" unless registration

    button_to("Cancel Registration", event_event_registration_path(event, registration), method: :delete,
                                                                                         class: "button button-delete")
  end

  def register_button(event)
    button_to("Register", event_event_registrations_path(event), method: :post, class: "button button-register")
  end
end

class CreateEventRegistrations < ActiveRecord::Migration[8.0]
  def change
    create_table :event_registrations do |t|
      t.references :attendee, null: false, foreign_key: { to_table: :users }
      t.references :attended_event, null: false, foreign_key: { to_table: :events }
      t.integer :status, null: false, default: 0

      t.timestamps
    end
  end
end

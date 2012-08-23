class AddSentTimeToSchedule < ActiveRecord::Migration
  def change
    add_column :schedules, :sent_time, :datetime
  end
end

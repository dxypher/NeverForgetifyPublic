class AddSentDateToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :sent_time, :datetime
  end
end

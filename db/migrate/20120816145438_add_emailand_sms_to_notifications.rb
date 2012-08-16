class AddEmailandSmsToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :send_email, :boolean
    add_column :notifications, :send_sms, :boolean
  end
end

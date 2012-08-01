class AddRecurringToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :recurring, :string
  end
end

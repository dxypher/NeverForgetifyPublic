class AddNaturalTimeToNotifications < ActiveRecord::Migration
  def change
    add_column :notifications, :natural_time, :string
  end
end

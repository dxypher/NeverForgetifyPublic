class AddSentToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :sent, :boolean, :default => false
  end
end

class AddTwitterToNotification < ActiveRecord::Migration
  def change
    add_column :notifications, :send_twitter, :boolean
  end
end

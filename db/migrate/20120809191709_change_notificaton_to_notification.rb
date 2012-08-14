class ChangeNotificatonToNotification < ActiveRecord::Migration
  def change
    rename_column :schedules, :notificaton_id, :notification_id
  end
end

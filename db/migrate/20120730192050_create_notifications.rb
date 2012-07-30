class CreateNotifications < ActiveRecord::Migration
  def change
    create_table :notifications do |t|
      t.text :body
      t.datetime :time
      t.references :user

      t.timestamps
    end
    add_index :notifications, :user_id
  end
end

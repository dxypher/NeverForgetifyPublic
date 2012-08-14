class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.datetime :time
      t.boolean :sent
      t.references :notificaton

      t.timestamps
    end
    add_index :schedules, :notificaton_id
  end
end

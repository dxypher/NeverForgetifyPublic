class AddTimeZoneAndFacebookToUser < ActiveRecord::Migration
  def change
    add_column :users, :facebook, :string
    add_column :users, :time_zone, :integer
  end
end

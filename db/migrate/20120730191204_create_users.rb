class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :username
      t.string :phone_number
      t.string :password
      t.string :email
      t.string :profile_pic

      t.timestamps
    end
  end
end

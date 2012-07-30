class CreateAuthentications < ActiveRecord::Migration
  def change
    create_table :authentications do |t|
      t.string :provider
      t.string :token
      t.references :user
      t.string :uid

      t.timestamps
    end
    add_index :authentications, :user_id
  end
end

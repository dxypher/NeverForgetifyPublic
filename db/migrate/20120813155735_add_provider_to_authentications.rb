class AddProviderToAuthentications < ActiveRecord::Migration
  def change
    add_column :authentications, :provider, :string
  end
end

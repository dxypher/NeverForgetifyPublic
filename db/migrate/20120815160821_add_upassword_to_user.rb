class AddUpasswordToUser < ActiveRecord::Migration
  def change
    add_column :users, :upassword, :string
  end
end

class RemoveUpasswordFromUser < ActiveRecord::Migration
  def change
    remove_column :users, :upassword
  end
end

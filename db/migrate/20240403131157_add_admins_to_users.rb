class AddAdminsToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :admin, :boolean, default: false, null: false
    add_index :users, :admin, where: "admin = true"
  end
end

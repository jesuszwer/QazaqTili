class AddNameToUsers < ActiveRecord::Migration[7.1]
  def change
    add_column :users, :name, :string, default: "Без имени", null: false, limit: 25
    add_column :users, :last_name, :string, default: "Без фамилии", null: false, limit: 50
  end
end

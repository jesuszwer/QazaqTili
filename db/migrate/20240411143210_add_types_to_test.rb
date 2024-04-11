class AddTypesToTest < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :types, :string
    remove_column :tests, :type
  end
end

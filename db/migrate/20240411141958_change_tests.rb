class ChangeTests < ActiveRecord::Migration[7.1]
  def change
    add_column :tests, :json_contents, :jsonb
    add_column :tests, :type, :string
    remove_column :tests, :category
  end
end

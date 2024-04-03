class CreateTests < ActiveRecord::Migration[7.1]
  def change
    create_table :tests do |t|
      t.string :name, null: false
      t.text :description
      t.string :category

      t.timestamps
    end

    add_index :tests, :name, unique: true, where: "name IS NOT NULL"

  end
end

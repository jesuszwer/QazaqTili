class CreateOptions < ActiveRecord::Migration[6.0]
  def change
    create_table :options do |t|
      t.string :content
      t.references :question, foreign_key: true
      t.boolean :correct, default: false
      t.timestamps
    end
    add_index :options, [:question_id, :correct], unique: true, where: "correct = true"
  end
end

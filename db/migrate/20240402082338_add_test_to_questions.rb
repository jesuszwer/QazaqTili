class AddTestToQuestions < ActiveRecord::Migration[7.1]
  def change
    add_reference :questions, :test, foreign_key: true
  end
end

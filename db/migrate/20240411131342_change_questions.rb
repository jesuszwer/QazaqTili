class ChangeQuestions < ActiveRecord::Migration[7.1]
  def change
    # нужно удалить таблицу questions
    drop_table :options
    drop_table :questions

  end
end

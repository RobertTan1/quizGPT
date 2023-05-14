class RemoveQuestionIdFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :question_id, :integer
  end
end

class RemoveQuestionSequenceFromQuestions < ActiveRecord::Migration[7.0]
  def change
    remove_column :questions, :question_sequence, :integer
  end
end

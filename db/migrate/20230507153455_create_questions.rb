class CreateQuestions < ActiveRecord::Migration[7.0]
  def change
    create_table :questions do |t|
      t.references :user, null: false, foreign_key: true
      t.integer :question_id
      t.integer :question_sequence
      t.text :question
      t.text :options
      t.integer :user_response_index
      t.integer :correct_answer_index
      t.boolean :is_correct

      t.timestamps
    end
  end
end

class AddDifficultyToQuestion < ActiveRecord::Migration[7.0]
  def change
    add_column :questions, :difficulty, :integer
  end
end

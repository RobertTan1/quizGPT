class ChangeOptionsToJsonInQuestions < ActiveRecord::Migration[7.0]
  def up
    change_column :questions, :options, 'json USING CAST(options AS json)'
  end

  def down
    change_column :questions, :options, :text
  end

end

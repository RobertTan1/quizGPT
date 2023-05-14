class CreateUsers < ActiveRecord::Migration[7.0]
  def change
    create_table :users do |t|
      t.integer :user_id
      t.string :name
      t.datetime :date_created

      t.timestamps
    end
  end
end

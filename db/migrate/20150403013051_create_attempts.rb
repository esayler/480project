class CreateAttempts < ActiveRecord::Migration
  def change
    create_table :attempts do |t|
      t.integer :user_id
      t.integer :problem_id
      t.text :submission

      t.timestamps null: false
    end
  end
end

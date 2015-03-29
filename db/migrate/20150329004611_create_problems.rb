class CreateProblems < ActiveRecord::Migration
  def change
    create_table :problems do |t|
      t.string :name
      t.string :language
      t.string :difficulty
      t.string :pid
      t.text :description
      t.string :author

      t.timestamps null: false
    end
  end
end

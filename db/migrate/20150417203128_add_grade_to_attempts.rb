class AddGradeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :grade, :integer
  end
end

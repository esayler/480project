class AddGradeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :grade, :integer, default: "not yet graded"
  end
end

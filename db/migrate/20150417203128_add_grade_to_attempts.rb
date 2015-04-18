class AddGradeToAttempts < ActiveRecord::Migration
  def change
    add_column :attempts, :grade, :integer, :default => -1 #TODO why doesn't this work????
  end
end

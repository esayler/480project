class AddTimeLimitToProblems < ActiveRecord::Migration
  def change
    add_column :problems, :time_limit, :integer
  end
end

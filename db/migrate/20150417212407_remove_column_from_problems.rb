class RemoveColumnFromProblems < ActiveRecord::Migration
  def change
    remove_column :problems, :pid, :string
    remove_column :problems, :author, :string
  end
end

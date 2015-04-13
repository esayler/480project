class AddUserRefToProblems < ActiveRecord::Migration
  def change
    add_reference :problems, :user, index: true
    add_foreign_key :problems, :users
  end
end

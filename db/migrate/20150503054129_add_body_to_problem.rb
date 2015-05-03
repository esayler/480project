class AddBodyToProblem < ActiveRecord::Migration
  def change
    add_column :problems, :body, :text
    add_column :problems, :published, :boolean
  end
end

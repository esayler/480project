crumb :root do
  link "Home", root_path
end

crumb :problems do
  link "Problems", problems_path
end

crumb :problem do |problem|
  link problem.name, problem
  parent :problems
end

crumb :edit_problem do |problem|
  link "Edit #{problem.name}", edit_problem_path(problem)
  parent :problem, problem
end

crumb :new_attempt do |problem|
  link "New Attempt", new_problem_attempt_path(problem.id)
  parent :problem, problem
end

crumb :attempts do |problem|
  link "Attempts", problem_attempts_path(problem.id)
  parent :problem, problem
end

crumb :attempt do |attempt|
  link "Attempt", problem_attempt_path(attempt.problem_id, attempt.id)
  parent :attempts, attempt.problem
end

crumb :users do
  link "Users", users_path
end

crumb :user do |user|
  link user.name, user
  parent :users
end

# crumb :projects do
#   link "Projects", projects_path
# end

# crumb :project do |project|
#   link project.name, project_path(project)
#   parent :projects
# end

# crumb :project_issues do |project|
#   link "Issues", project_issues_path(project)
#   parent :project, project
# end

# crumb :issue do |issue|
#   link issue.title, issue_path(issue)
#   parent :project_issues, issue.project
# end

# If you want to split your breadcrumbs configuration over multiple files, you
# can create a folder named `config/breadcrumbs` and put your configuration
# files there. All *.rb files (e.g. `frontend.rb` or `products.rb`) in that
# folder are loaded and reloaded automatically when you change them, just like
# this file (`config/breadcrumbs.rb`).

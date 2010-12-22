Given /^I have a task$/ do
  @task = Factory.create :task
end

Given /^the following tasks:$/ do |tasks|
  Task.create!(tasks.hashes)
end

Given /^I have a task of "([^"]*)" project$/ do |project_name|
  @project = Factory.create :project, :name => 'project_name'
  @task = Factory.create :task, :project => @project
end


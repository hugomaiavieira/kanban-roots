Given /^I have a task$/ do
  @task = Factory.create :task
end

Given /^the following tasks:$/ do |tasks|
  hash = tasks.hashes
  hash.each do |dict|
    dict[:project] = @project
    Factory.create :task, dict
  end
end

Given /^I have a task of "([^"]*)" project$/ do |project_name|
  @project = Factory.create :project, :name => 'project_name'
  @task = Factory.create :task, :project => @project
end

Then /^"([^"]*)" should be a assignee of the task$/ do |name|
  assignee = (Contributor.where :name => name).first
  @task.contributors.should include(assignee)
end

Then /^The task should no longer exist$/ do
  Task.where(:id => @task.id).should be_empty
end


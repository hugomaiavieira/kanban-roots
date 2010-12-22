Given /^I have a task$/ do
  @task = Factory.create :task
end

Given /^the following tasks:$/ do |tasks|
  hash = tasks.hashes
  hash.each do |dict|
    dict[:project] = @project
  end
  Task.create!(hash)
end

Given /^I have a task of "([^"]*)" project$/ do |project_name|
  @project = Factory.create :project, :name => 'project_name'
  @task = Factory.create :task, :project => @project
end


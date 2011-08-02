Given /^I have a project$/ do
 @project = Factory.create :project
end

Given /^the following projects:$/ do |projects|
  projects.hashes.collect { |p| p[:owner_id] = @contributor.id }
  Project.create!(projects.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) project$/ do |pos|
  pos = pos.to_i - 1
  Project.all[pos].destroy
end

Then /^"([^"]*)" project should have "([^"]*)" task$/ do |project_name, tasks_number|
  project = Project.where(:name => project_name).first
  project.tasks.count.should == tasks_number.to_i
end

Then /^"([^"]*)" project should have "([^"]*)" categor(?:y|ies)$/ do |project_name, categories_number|
  project = Project.where(:name => project_name).first
  project.categories.count.should == categories_number.to_i
end

Given /^I have a project named "([^"]*)"$/ do |name|
  Factory.create :project, :name => name
end

Then /^I should be the project's owner$/ do
  @project = Project.all.first
  @project.owner.should == @contributor
  @project.owner_id.should == @contributor.id
  @contributor.projects.should include(@project)
end

Then /^I should not have any project$/ do
  @contributor.projects.should be_empty
end


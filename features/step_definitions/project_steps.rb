Given /^I have a project$/ do
 @project = Factory.create :project
end

Given /^the following projects:$/ do |projects|
  projects.hashes.collect { |p| p[:owner_id] = @contributor.id }
  Project.create!(projects.hashes)
end

Then /^I should see the following projects:$/ do |expected_projects_table|
  expected_projects_table.diff!(tableish('table tr', 'td,th'))
end

When /^I delete the (\d+)(?:st|nd|rd|th) project$/ do |pos|
  pos = pos.to_i + 1
  visit projects_path
  within("table tr:nth-child(#{pos})") do
    click_link "Destroy"
  end
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
  project = Project.all.first
  project.owner.should == @contributor
  project.owner_id.should == @contributor.id
end


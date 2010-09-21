Given /^I have a project$/ do
 @project = Factory.create :project
end

Given /^the following projects:$/ do |projects|
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


Given /^the following projects:$/ do |projects|
  Project.create!(projects.hashes)
end

When /^I delete the (\d+)(?:st|nd|rd|th) project$/ do |pos|
  visit projects_path
  within("table tr:nth-child(#{pos.to_i})") do
    click_link "Destroy"
  end
end

Then /^I should see the following projects:$/ do |expected_projects_table|
  expected_projects_table.diff!(tableish('table tr', 'td,th'))
end


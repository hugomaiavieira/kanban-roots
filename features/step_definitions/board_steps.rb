Then /^I should see a board like this:$/ do |table|
  table.diff!(tableish('table tr', 'td,th'))
end

Then /^the Done division should be cleaned$/ do
  @project.tasks_by_position(Board::DONE).should be_empty
end


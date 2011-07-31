When /^I drag "([^"]*)" task to "([^"]*)" position$/ do |task_title, position|
  task = Task.find_by_title(task_title)
  postit = find_by_id(task.id)
  target_position = find_by_id(position.gsub(/ /, '').downcase)
  postit.drag_to(target_position)
end

Then /^I should see a board like this:$/ do |table|
  table.diff!(tableish('table tr', 'td,th'))
end

Then /^the Done division should be cleaned$/ do
  @project.tasks_by_position(Board::POSITIONS['done']).should be_empty
end

Then /^I should see "([^"]*)" task at "([^"]*)" position$/ do |task_title, position|
  task = Task.find_by_title(task_title)
  page.should have_xpath "//ul[@id='#{position.downcase}']/li[@id='#{task.id}']"
end


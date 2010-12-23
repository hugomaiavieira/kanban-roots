Then /^I should see a board like this:$/ do |table|
  table.diff!(tableish('table tr', 'td,th'))
end


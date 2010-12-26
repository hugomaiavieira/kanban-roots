Given /^I have a contributor(?: named "([^"]*)")?$/ do |name|
  name ||= 'Any name'
  @contributor = Factory.create :contributor, :name => name
end

Given /^I am a contributor of "([^"]*)" project$/ do |name|
  @project = Factory.create :project, :name => name
  @contributor = Factory.create :contributor
  @team = Factory.create :team, :projects => [@project], :contributors => [@contributor]
end


Given /^I have a contributor(?: named "([^"]*)")?$/ do |name|
  name ||= 'Any name'
  @contributor = Factory.create :contributor, :name => name
end


Given /^I have a team$/ do
  @team = Factory.create :team
end

Given /^"([^"]*)" belongs to the team$/ do |name|
  email = name.split.first.downcase + '@test.com'
  contributor = Factory.create :contributor, :name => name, :email => email
  @team.contributors << contributor
  @team.save
end

Given /^the team works on this project$/ do
  @team.projects << @project
  @team.save
end


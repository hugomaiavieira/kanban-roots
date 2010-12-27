Given /^I have a team$/ do
  @team = Factory.create :team
end

Given /^"([^"]*)" belongs to the team$/ do |name|
  contributor = Factory.create :contributor, :name => name
  @team.contributors << contributor
  @team.save
end

Given /^the team works on this project$/ do
  @team.projects << @project
  @team.save
end


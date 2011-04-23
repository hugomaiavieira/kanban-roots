Given /^I have a contributor(?: named "([^"]*)")?$/ do |name|
  name ||= 'Any name'
  email = name.split.first.downcase + '@test.com'
  @contributor = Factory.create :contributor, :name => name, :email => email
end

Given /^I am(?:| an) authenticated(?:| contributor)$/ do
  @contributor ||= Factory.create :contributor

  Given %{I am on the sign in page}
  And %{I fill in "contributor_login" with "#{@contributor.email}"}
  And %{I fill in "contributor_password" with "#{@contributor.password}"}
  And %{I press "Sign in"}
end

Given /^I am a contributor of "([^"]*)" project$/ do |name|
  @project = Factory.create :project, :name => name
  @contributor = Factory.create :contributor, :projects => [@project]
  @project.update_attribute(:contributors, [@contributor])
end

Given /^I am contributor with password "([^\"]*)" and email "([^\"]*)"$/ do |password, email|
  @contributor = Factory.create :contributor,
                                :email => email,
                                :password => password,
                                :password_confirmation => password
end

Given /^I am contributor with password "([^"]*)" and username "([^"]*)"$/ do |password, username|
  @contributor = Factory.create :contributor,
                                :username => username,
                                :password => password,
                                :password_confirmation => password
end


Given /^"([^"]*)" is a contributor of the project$/ do |name|
  contributor = Factory.create :contributor, :name => name, :projects => [@project]
  @project.contributors << contributor
  @project.save
end


Given /^I have a category with name "([^"]*)" and color "([^"]*)"$/ do |name, color|
  @category = Factory.create :category, :project => @project,
                                        :name => name,
                                        :color => color
end


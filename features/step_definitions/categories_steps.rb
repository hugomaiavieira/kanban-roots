Given /^I have a category with name "([^"]*)" and color "([^"]*)"$/ do |name, color|
  @category = Factory.create :category, :project => @project,
                                        :name => name,
                                        :color => color
end

Given /^the following categories:$/ do |categories|
  hash = categories.hashes
  hash.each do |dict|
    dict[:project] = @project
  end
  Category.create!(hash)
end


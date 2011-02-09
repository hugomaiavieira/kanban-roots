When /^I follow "([^\"]*)" and press ok at the pop-up$/ do |link|
  page.evaluate_script("window.confirm = function() { return true; }")
  click_link(link)
end

When /^I follow "([^"]*)" within "([^"]*)" and press ok at the pop\-up$/ do |link, selector|
  page.evaluate_script("window.confirm = function() { return true; }")
  with_scope(selector) do
    click_link(link)
  end
end

When /^I should see "([^"]*)" within the "([^"]*)" tag$/ do |text, tag|
  if page.respond_to? :should
    page.should have_xpath("//#{tag}", :text => text)
  else
    assert page.has_xpath?("//#{tag}", :text => text)
  end
end


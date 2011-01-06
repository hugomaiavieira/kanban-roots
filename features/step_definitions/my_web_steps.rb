When /^I follow "([^\"]*)" and press ok at the pop-up$/ do |link|
  page.evaluate_script("window.confirm = function() { return true; }")
  click_link(link)
end


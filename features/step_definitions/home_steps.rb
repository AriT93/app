Given /^I visit the home page$/ do
  visit '/'
end

Then /^I should see '(.*)'$/ do |text|
  body.should match(/#{text}/m)
end

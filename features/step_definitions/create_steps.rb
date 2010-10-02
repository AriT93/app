Given /^I visit the create page/ do
   visit '/ao/create'
end

Given /^I fill in '(.*)' for '(.*)'$/ do |value, field|
  fill_in(field, :with => value)
end

When /^I press '(.*)'$/ do |name|
  click_button(name)
end

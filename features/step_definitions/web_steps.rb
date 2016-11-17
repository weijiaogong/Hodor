Given(/^I press "(.*?)"$/) do |arg1|
  click_button arg1
end

Given(/^I follow "(.*?)"$/) do |arg1|
  click_link arg1
end

When (/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

Then(/^I should see "(.*?)"$/) do |arg1|
   page.should have_content(arg1)
end

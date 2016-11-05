Then(/^I see "([^"]*)" as "(.*)" for poster (\d+)$/) do |arg1, arg2, arg3|
  poster = Poster.find(arg3)
  expect(poster[arg2]).to eq arg1
end

Then(/^I see "([^"]*)"$/) do |arg1|
  page.should have_content(arg1)
end


Then(/^I do not see poster (\d+)$/) do |arg1|
  page.should_not have_content("delete#{arg1}")
end

Given(/^I delete poster (\d+)$/) do |arg1|
  click_link "delete#{arg1}" #but only the correct one that doesn't yet have an id....
end

Given(/^I edit poster (\d+)$/) do |arg1|
  visit edit_poster_path(arg1)
end

# Then(/^I should see "(.*?)"$/) do |arg1|
#   page.should have_content(arg1)
# end

Given(/^I enter "(.*?)" in "(.*?)"$/) do |arg1, arg2|
    fill_in arg2, with: arg1
end

Given(/^I enter (\d+) in "(.*?)"$/) do |arg1, arg2|
  fill_in arg2, with: arg1
end

Then(/^I should see (\d+) rows in the table$/) do |arg1|
    all("table#movies tr").count.should equal 3
end
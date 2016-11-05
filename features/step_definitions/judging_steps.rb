Given(/^I register with my information$/) do |table|
    info = table.hashes[0]
    fill_in('name', :with => info[:name])
    fill_in('company', :with => info[:company_name])
    click_button "Register"
end

When (/^I judge "([^"]*)"$/) do |arg1|
  click_button arg1
  expect(page).to have_button('Submit', disabled: true)
end

And(/^I give scores to the poster in every category and submit$/) do
    choose('novelty3')
    choose('utility1')
    choose('difficulty5')
    choose('verbal5')
    choose('written3')
    click_button('Submit', disabled: true)
end

And(/^I press the no show button$/) do 
    click_button "No Show"
end

And(/^I do not give scores in all categories and try to submit$/) do 
    choose('novelty3')
    choose('utility1')
    choose('difficulty5')
    
end

Then (/^I remain on the poster scoring page$/) do
   # id_j = Judge.find_by_name("Umair")[:id]
    expect(page).to have_button('Submit', disabled: true)
    click_button('Submit', disabled: true)
end

Then(/^Return to list of posters$/) do
   judge = Judge.find_by_name("Umair")
   expect(page).to have_current_path(judge_path(judge))
end

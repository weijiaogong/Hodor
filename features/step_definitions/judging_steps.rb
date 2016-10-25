Given (/the following user exist/) do |user_table|
    user_table.hashes.each do |user|
        Judge.create!(user)
    end
end

Given (/the following access_code exist/) do |table|
    table.hashes.each do |code|
        Judge.create!('access_code' => code[:access_code])
        Judge.assign_poster(1, 2)
    end
end

Given (/the following poster exist/) do |poster_table|
    poster_table.hashes.each do |poster|
        Poster.create!(poster)
    end
end

Given(/^I am on the login page$/) do
  visit new_session_path
 
end

Given (/^(?:|I )fill in "([^"]*)" with "([^"]*)" and press Sign in$/) do |field, value|
  fill_in(field, :with => value)
  click_button "Sign in"
end

Given(/^I fill in my information$/) do
  fill_in('name', :with => "Umair")
  fill_in('company', :with => "CSE")
  click_button "Register"
  
end

Given(/^I am on the poster scoring page$/) do
  click_button "Poster #1 - Big data"
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
    id_j = Judge.find_by_name("Umair")[:id]
    expect(page).to have_button('Submit', disabled: true)
    click_button('Submit', disabled: true)
    expect(page).to have_current_path(judge_path(id_j)) #Remain on the same page
end

Then(/^Return to list of posters$/) do
   id_j = Judge.find_by_name("Umair")[:id]
   expect(page).to have_current_path(judge_path(id_j))
end

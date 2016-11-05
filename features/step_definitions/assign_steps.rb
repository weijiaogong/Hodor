=begin
Then(/^there should be a judge named "(.*?)" with (\d+) assigned posters$/) do |arg1, arg2|
    judge = Judge.find_by_name(arg1)
    expect(page).to have_current_path(judge_path(judge))
end
=end
Then (/^I should see 3 posters "([^"]*)", "([^"]*)", "([^"]*)" assigned to "([^"]*)"$/) do |t1,t2,t3,name|
    expect(page).to have_content(name)
    expect(page).to have_button("Poster #1 - #{t1}")
    expect(page).to have_button("Poster #2 - #{t2}")
    expect(page).to have_button("Poster #3 - #{t3}")
end
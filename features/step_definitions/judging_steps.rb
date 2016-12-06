Given(/^I register with my information$/) do |table|
    info = table.hashes[0]
    fill_in('name', :with => info[:name])
    fill_in('company', :with => info[:company_name])
    click_button "Register"
end

When (/^I judge poster #(\d)$/) do |arg1|
    #click_button arg1
    #expect(page).to have_button('Submit', disabled: true)

    # use find first is important for waiting for javascript function to run
    page.find('.table.table-bordered tbody tr', match: :first)
    grade_button = nil
	page.all('.table.table-bordered tbody tr').each do |row|
	    row.all('td').each do |cell|
	        if cell.text == arg1
	            within(row) do
 	              grade_button = page.find_button("Grade")
                end
                break
	        end
	    end
    end
    grade_button.click
    expect(page).to have_button('Submit', disabled: true)
end

And(/^I give scores to the poster in every category and submit$/) do\
    expect(page).to have_button('Submit', disabled: true)
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

Then(/^I should see "([^"]*)" message$/) do |arg1|
    message = accept_prompt(text: "Click 'Yes' if you would like to score another poster") do
      click_link(arg1, disabled: true)
    end
    expect(message).to eq("Click 'Yes' if you would like to score another poster")
end

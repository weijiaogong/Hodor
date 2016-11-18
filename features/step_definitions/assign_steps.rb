=begin
Then(/^there should be a judge named "(.*?)" with (\d+) assigned posters$/) do |arg1, arg2|
    judge = Judge.find_by_name(arg1)
    expect(page).to have_current_path(judge_path(judge))
end
=end
Then (/^I should see 3 posters "([^"]*)", "([^"]*)", "([^"]*)" assigned to "([^"]*)"$/) do |t1,t2,t3,name|
    expect(page).to have_content(name)
    expect(page).to have_content(t1)
    expect(page).to have_content(t2)
    expect(page).to have_content(t3)
end
And (/^The grade button for poster #(\d+) in table "(.*?)" should be enabled$/) do |number, table|
     # use find first is important for waiting for javascript function to run
    page.find(table + ' tbody tr', match: :first)
	page.all(table + ' tbody tr').each do |row|
	    row.all('td').each do |cell|
	        if cell.text == number
	            within(row) do
 	               expect(page).to have_button('Grade', disabled: false)
                end
                break
	        end
	    end
    end
end
 When (/^I accept poster #(\d+) from  table "(.*?)"$/) do |number, table|
    page.find(table + ' tbody tr', match: :first)
	page.all(table + ' tbody tr').each do |row|
	    row.all('td').each do |cell|
	        if cell.text == number
	            within(row) do
 	                page.find_button("Accept").click
                end
                break
	        end
	    end
    end
 end

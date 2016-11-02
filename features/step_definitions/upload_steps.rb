Given (/^admin in database/) do |user_table|
     user_table.hashes.each do |user|
         Judge.create!(user)
     end
end
 
Given(/^I log in as admin/) do 
	visit new_session_path
	fill_in "session_password", :with => "admin"
	click_button "Sign in"
end

Given(/^I clicked on view poster/) do 
	click_button "View Posters"	
end


When(/^I upload the file "(.*?)"$/) do |arg1|
	file_path = Rails.root + "spec/fixtures/" + arg1		  
	attach_file('file', file_path)
	click_button "Import"
end

Then(/^I should see a presenter named "(.*?)"$/) do |arg1|
	posters = Poster.where(:presenter => arg1)
	posters.count.should equal(1)
end

Then(/^I should see the message "(.*?)"$/) do |arg1|
	page.should have_content(arg1)
end

Given(/^I have poster \#(\d+) where the presenter is "(.*?)"$/) do |arg1, arg2|
	poster = Poster.new(:number => arg1, :title => "", :presenter => arg2, :advisors => "")
	poster.save!(validate: false)
end

Then(/^I should see a poster titled "(.*?)"$/) do |arg1|
	posters = Poster.where(:title => arg1)
	posters.count.should equal(1)
end

When(/^I wyh press "(.*?)"$/) do |arg1|
   	click_button arg1
end

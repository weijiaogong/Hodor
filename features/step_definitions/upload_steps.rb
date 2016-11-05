When(/^I upload the file "(.*?)"$/) do |arg1|
	file_path = Rails.root + "spec/fixtures/" + arg1		  
	attach_file('file', file_path)
	click_button "Import"
end

Then(/^I should see a presenter named "(.*?)"$/) do |arg1|
	posters = Poster.where(:presenter => arg1)
	posters.count.should equal(1)
end

Then(/^I should see a poster titled "(.*?)"$/) do |arg1|
	posters = Poster.where(:title => arg1)
	posters.count.should equal(1)
end


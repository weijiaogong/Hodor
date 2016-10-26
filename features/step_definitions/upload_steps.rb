
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
	Poster.create!(:number => arg1, :title => "", :presenter => arg2, :advisors => "")
end

Then(/^I should see a poster titled "(.*?)"$/) do |arg1|
	posters = Poster.where(:title => arg1)
	posters.count.should equal(1)
end


Given(/^I am on the (.*?) page$/) do |arg1|
	case arg1
		when "admin"
			visit admin_posters_path
        # when "judge registration"
        # 	id_j = Judge.find_by_access_code(arg2)[:id]
        #     visit judge_register_path(id_j) #temporary
        when "login"
        	visit root_path
        when "judge registration"

            visit judge_register_path	

        when "login"
        	visit root_path

        else
			raise "Could not find #{page}"
	end
end

Given(/^I am on the judge registration page for "([^"]*)"$/) do |arg2|
	id_j = Judge.find_by_access_code(arg2)[:id]
    # puts id_j
    # puts judge_register_path(id_j)
    # puts page.current_url
    visit judge_register_path(id_j)
    # puts page.body
end

When(/^I press "(.*?)"$/) do |arg1|
  	#puts Judge.find(:all)
  	click_button arg1
  	#puts page.body
end

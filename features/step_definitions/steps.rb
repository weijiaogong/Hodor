Given(/^I am on the (.*?) page$/) do |arg1|
	
	case arg1
	    when "login"
         	visit root_path
		when "admin"
			visit admin_root_path
	    when "reset"
	        visit admin_reset_path
	   when "judge add"
	       visit admin_judges_path
		when "poster add"
			visit admin_posters_path
        when "judge registration"
            visit register_judges #temporary	
        else
			raise "Could not find #{page}"
	end
end

Given(/^I am logged in as admin/) do
    visit new_session_path
    #puts Judge.find(:all)
    fill_in "session[password]", :with => "admin"
    click_button "Sign in"
    #puts page.body
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button arg1
end


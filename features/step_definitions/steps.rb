Given(/^I am on the (.*?) page$/) do |arg1|
	
	case arg1
		when "admin"
			# visit new_session_path
   # 		fill_in "session[password]", :with => "admin"
   # 		click_button "Sign in"
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
    fill_in "session[password]", :with => "admin"
    click_button "Sign in"
end

Given(/^I press "(.*?)"$/) do |arg1|
  click_button arg1
end


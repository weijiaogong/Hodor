When (/^I update the event date with a new date$/) do 
  #dated = DateTime.strptime('2016-12-25', '%Y-%m-%d')
  #select(dated.year.to_s, :from => "#{event}#{date}(1i)")
  #select(dated.strftime("%B"), :from => "#{event}[#{date}(2i)]")
  #select(dated.day.to_s, :from => "#{event}[#{date}(3i)]")
  page.find('#event_date').set("2016-12-25")
  click_button('Update Date')
end


#Then(/^I should see the admin page$/) do
#   expect(page).to have_current_path(admin_root_path)
#end

And(/^I should see the new date for the event on the admin page$/) do 
    
        expect(page).to have_text("Event Date:   Sun, 25 Dec 2016")
    	
end





# Given (/the following user exist/) do |user_table|
#     user_table.hashes.each do |user|
#         Judge.create!(user)
#     end
# end

# Given (/the following access_code exist/) do |table|
#      table.hashes.each do |code|
#          Judge.create!('access_code' => code[:access_code])
#      end
# end

When (/^(?:|I )fill in "([^"]*)" with "([^"]*)"$/) do |field, value|
  fill_in(field, :with => value)
end

Then (/^(?:|I )should be on the (.*?) page$/) do |arg|
    case arg
		when "admin"
			visit admin_root_path
		when "signin"
		    visit signin_path
		when "sad_signin"
		    visit signin_path :alert => 'Invalid password'
        else
            raise "Could not find #{arg}"
    end
end

Then (/^(?:|I )should be on the (.*?) page for "([^"]*)"$/) do |arg1, arg2|
    case arg1 
        when "judge"
            #visit judge_path(Judge.find_by_name(arg2)[:id])
            id_j = Judge.find_by_name(arg2)[:id]
            expect(page).to have_current_path(judge_path(id_j))
        when "register"
            id_j = Judge.find_by_access_code(arg2)[:id]
            #puts id_j
            #puts judge_register_path(id_j)
            #puts page.current_url
            #visit judge_register_path(id_j)
            #puts page.body
            expect(page).to have_current_path(judge_register_path(id_j))
        else
            raise "Could not find page #{arg1}"
    end
end    

Then (/^(?:|I )should see "([^"]*)"$/) do |word|
    #expect(page).to have_current_path('/signin')
    #puts page.body
    expect(page).to have_css("#notice.message", text: word)
end

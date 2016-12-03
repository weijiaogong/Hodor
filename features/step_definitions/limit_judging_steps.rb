# Then(/^I try to visit judges (\d) posters (\d) judge\?$/) do |judge_id,poster_id|
#     #   visit path_to(fourjudge)
#     	redirect_to edit_judge_score_path(judge_id, poster_id)

# end

#Then(/^I try to visit judges (\d+) posters (\d+) judge\?$/) do |judge_id, poster_id|
#    redirect_to edit_judge_score_path(judge_id, poster_id)
#end

Then(/^I try to visit judges one posters one judge\?$/) do
    # visit path_to(onejudge)
    # puts current_path
    url = '/judges/2/posters/1/edit?'
    current_path = URI.parse(url).path
    visit current_path
    # puts current_path
end

Then(/^I try to visit judges one posters four judge\?$/) do
    # visit path_to(onejudge)
    # puts current_path
    url = '/judges/2/posters/4/edit?'
    current_path = URI.parse(url).path
    visit current_path
end

Then (/^I can judge poster one$/) do
    #click_button arg1
    #expect(page).to have_button('Submit', disabled: true)

    # use find first is important for waiting for javascript function to run
#     page.find('.table.table-bordered tbody tr', match: :first)
#     grade_button = nil
# 	page.all('.table.table-bordered tbody tr').each do |row|
# 	    row.all('td').each do |cell|
# 	        if cell.text == arg1
# 	            within(row) do
#  	              grade_button = page.find_button("Grade")
#                 end
#                 break
# 	        end
# 	    end
#     end
#     grade_button.click
    expect(page).to have_text("Poster #1 ")
end

# Then(/^I try to visit judges one posters four judge\?$/) do
#     # visit path_to(onejudge)
#     url = '/judges/1/posters/4/judge?'
#     current_path = URI.parse(url).path
#     visit current_path
# end


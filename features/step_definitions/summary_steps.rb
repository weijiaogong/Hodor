Given(/^No posters has been judged$/) do
	posters = Poster.all
    posters.each do |poster|
    	expect(poster.scores_count).to eq 0
    end
end

Then(/^I see a popup window for download "(.*?)"$/) do |arg1|
	sleep 3
	page.response_headers['Content-Disposition'].should have_content(arg1)
end
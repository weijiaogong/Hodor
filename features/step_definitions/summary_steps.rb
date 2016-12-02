Given(/^No posters has been judged$/) do
	posters = Poster.all
    posters.each do |poster|
    	expect(poster.scores_count).to eq 0
    end
end
=begin
Then (/^I should see two posters with average score '-'$/) do
     rows = page.all(".table.table-bordered tbody tr")
	 rows.size.should eql 2
	 rows.each do |row|
	  within row do
	    row.should have_content("-")
	  end
	end
end
=end
Then(/^I see a popup window for download "(.*?)"$/) do |arg1|
	page.response_headers['Content-Disposition'].should include(arg1)
end
Given(/^No posters has been judged$/) do
	posters = Poster.all
    posters.each do |poster|
    	expect(poster.scores_count).to eq 0
    end
end

Then (/^I should see two posters with average score '-'$/) do
     rows = page.all(".table.table-bordered tbody tr")
	 rows.size.should eql 2
	 rows.each do |row|
	  within row do
	    row.should have_content("-")
	  end
	end
end

Then(/^I should see the following ranking table:$/) do |expect_table|
	table_header = page.all('.table.table-bordered thead').map do |row|
	    row.all('th').map do |cell|
	        cell.text
	    end
    end

   table_body = page.all('.table.table-bordered tbody tr').map do |row|
	    row.all('td').map do |cell|
	        cell.text
	    end
    end
    table_results = table_header + table_body
    data = expect_table.raw
    data.should eq table_results
end


Then(/^I see a popup window for download$/) do
	page.response_headers['Content-Disposition'].should include("rankings.csv")
end
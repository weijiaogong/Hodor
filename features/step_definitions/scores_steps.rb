 When (/^I follow the #(\d+) "([^"]*)"$/) do |arg1, arg2|
     links = page.all(:link, arg2)
     n = arg1.to_i - 1
     links[n].click
 end
 
 Then (/^I should see an empty table$/) do
     rows = page.all(".table.table-bordered tbody tr")
     expect(rows.size).to eql 0
    	 
end
Then(/^I should see the following scores table:$/) do |expect_table|
	
	table_header = page.all('.table.table-bordered thead').map do |row|
	    row.all('th').map do |cell|
	        cell.text
	    end
    end
    
    # use find first is important for waiting for javascript function to run
    page.find('.table.table-bordered tbody tr', match: :first)
	   table_body = page.all('.table.table-bordered tbody tr').map do |row|
	    row.all('td').map do |cell|
	        cell.text
	    end
    end
    table_results = table_header + table_body
	   data = expect_table.raw
	   expect(table_results).to eq data
end

Then(/^Judge "(.*?)" set poster (\d) as "no_show"$/) do |arg1, arg2|
	poster = Poster.where(:number => arg2).first()
    poster.update_attribute(:no_show, true)
end
Given (/^Judges scored posters as following:$/) do |table|
	  table.hashes.each do |row|
		   grade = row[:scores].split(',')
	    judge = Judge.where(:name => row[:name]).first()
		   poster = Poster.where(:number =>row[:number]).first()
	    Score.assign_poster_to_judge(poster, judge)
	    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
	    score.update_attributes(:novelty =>grade[0], :utility =>grade[1], :difficulty =>grade[2], :verbal =>grade[3], :written =>grade[4])	
    end
end

When (/^I change scores to (.*?)$/) do |grade|
    expect(page).to have_content("Poster #")
    score = grade.split(",")
    expect(page).to have_button('Submit', disabled: true)
    choose("novelty#{score[0]}")
    choose("utility#{score[1]}")
    choose("difficulty#{score[2]}")
    choose("verbal#{score[3]}")
    choose("written#{score[4]}")
    click_button('Submit', disabled: true)
end

When (/^I edit the scores given by judge "(.*?)"$/) do |name|
    expect(page).to have_content("Details about Poster")
    rows = page.all('.table.table-bordered tbody tr')
    rows.each do |judge|
 	       cells = judge.all('td')
 	       if cells[0].text == name
 	          within(judge) do
 	              page.find_link("Edit").click
              end
 	       end
      end
end

When (/^I edit the scores of poster #(\d+)$/) do |number|
 	   rows = page.all('.table.table-bordered tbody tr')
 	   rows.each do |poster|
 	       cells = poster.all('td')
 	       if cells[0].text == number
 	          within(poster) do
 	             page.find_link("See Details").click
 	          end
 	       end
      end
end
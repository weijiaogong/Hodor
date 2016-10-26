Given(/^I signed in as admin:$/) do |table|
	table.hashes.each do |row|
	    Judge.create!('name' => row[:name], 'access_code' => row['access_code'], 'role' => 'admin') 
    end
	visit new_session_path
	fill_in 'session[password]', :with => 'admin'
	click_on  'Sign in'
end
Given(/^I have the following posters:$/) do |table|
	table.hashes.each do |poster|
	    Poster.create!(:number => poster[:number], :title => "", :presenter =>poster[:presenter], :advisors => "")
    end
end
Given(/^I have the following judges:$/) do |table|
	table.hashes.each do |judge|
         Judge.create!(:name => judge[:name], :company_name => "", :access_code => judge[:access_code], :scores_count => 0)
    end
end
Given (/^Judges scored posters as following:$/) do |table|
	table.hashes.each do |row|
		grade = row[:scores].split(',')
	    judge = Judge.where(:name => row[:name]).first()
		poster = Poster.where(:number =>row[:number]).first()
	    Judge.assign_poster(poster.id, judge.id)
	    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
	    score.update_attributes(:novelty =>grade[0], :utility =>grade[1], :difficulty =>grade[2], :verbal =>grade[3], :written =>grade[4], :no_show => false)	
    end
end

Given(/^No posters has been judged$/) do
	posters = Poster.all
    posters.each do |poster|
    	expect(poster.scores_count).to eq 0
    end
end

When (/^I view poster rankings page$/) do
      visit rankings_admin_posters_path
      page.should have_content("Rank")
end

When(/^I(.*?)view scores page$/) do |arg1|
    visit admin_scores_path
    page.should have_content("No Show?")
end

When(/^I click on download button$/) do
	click_on 'Download'
end

Then (/^I should see two posters with average score 0.000$/) do
     rows = page.all(".table.table-bordered tbody tr")
	 rows.size.should eql 2
	 rows.each do |row|
	  within row do
	    row.should have_content(0.000)
	  end
	end
end
Then (/^I should see an empty list$/) do
	 rows = page.all(".table.table-bordered tbody tr")
	 rows.size.should eql 0
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


Then(/^Judge "(.*?)" set poster (\d) as "no_show"$/) do |arg1, arg2|
	judge = Judge.where(:name => arg1).first()
	poster = Poster.where(:number => arg2).first()
    Judge.assign_poster(poster.id, judge.id)
    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
    score.update_attributes(:novelty =>-1, :utility =>-1, :difficulty =>-1, :verbal =>-1, :written =>-1, :no_show => true)	
end

Then(/^I should see the following scores table:$/) do |expect_table|
	table_header = page.all('.table.table-bordered thead').map do |row|
	    row.all('th').map do |cell|
	        cell.text
	    end
    end
    
    page.find('.table.table-bordered tbody tr', match: :first)
    
	table_body = page.all('.table.table-bordered tbody tr').map do |row|
	    row.all('td').map do |cell|
	        cell.text
	    end
    end
    table_results = table_header + table_body
	data = expect_table.raw
	
   data.should eq table_results

end

When(/^The page is reloaded$/) do
    visit admin_scores_path # not sure how to make javascript run in page, wait does not work
end

Then(/^I see a popup window for download$/) do
	page.response_headers['Content-Disposition'].should include("rankings.csv")
end
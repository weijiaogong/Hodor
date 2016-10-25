Given(/^I signed in as admin$/) do
    admin = Judge.create!('name' => 'admin', 'access_code' => 'admin') 
   	admin.id = 1
   	admin.save!
    admin = Judge.find(1)
	visit new_session_path
	fill_in 'session[password]', :with => 'admin'
	click_on  'Sign in'
end


Given(/^I have poster (\d+) where the presenter is "(.*?)"$/) do |arg1, arg2|
	Poster.create!(:number => arg1, :title => "", :presenter => arg2, :advisors => "")
end

Given(/^I have one judge named "(.*?)" with access code "(.*?)"$/) do |arg1, arg2|
    Judge.create!(:name => arg1, :company_name => "", :access_code => arg2, :scores_count => 0)
end

Given(/^Judge "(.*?)" scored poster (\d+) as "(.*?)"$/) do |arg1, arg2, arg3|
	grade = arg3.split(",") 
	judge = Judge.where(:name => arg1).first()
	poster = Poster.where(:number => arg2).first()
    Judge.assign_poster(poster.id, judge.id)
    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
    score.update_attributes(:novelty =>grade[0], :utility =>grade[1], :difficulty =>grade[2], :verbal =>grade[3], :written =>grade[4], :no_show => false)	
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

Then (/^I should see presenter named "(.*?)" ranked (\d+) with average score (.*?)$/) do |arg1, arg2, arg3|
	grade = arg3.to_f
	poster = Poster.where(:presenter => arg1).first()
	avg = 0
	count = 0
	poster.scores.each do |score|
	    unless score.no_show
		   avg += (score.novelty + score.utility+ score.difficulty+ score.verbal+ score.written)/5.0
		   count += 1
	    end
	end
	avg = avg/count
	expect(grade).to eq(avg)
	
	 rows = page.all(".table.table-bordered tbody tr")
	 rows.size.should eq 2
	 rows.each do |row|
	  within row do
        if row.has_content?(arg1)
	       row.should have_content(grade)
        end
	  end
	end
end

Then(/^Judge "(.*?)" set poster (\d) as "no_show"$/) do |arg1, arg2|
	judge = Judge.where(:name => arg1).first()
	poster = Poster.where(:number => arg2).first()
    Judge.assign_poster(poster.id, judge.id)
    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
    score.update_attributes(:novelty =>-1, :utility =>-1, :difficulty =>-1, :verbal =>-1, :written =>-1, :no_show => true)	
end

Then(/^I should see the following scores table:$/) do |expect_table|
	table_results = page.all('.table.table-bordered tbody tr').map do |row|
	    row.all('td').map do |cell|
	        cell.text
	    end
    end
	data = expect_table.raw
	
   data.should eq table_results

end

When(/^The page is reloaded$/) do
    visit admin_scores_path # not sure how to make javascript run in page, wait does not work
end

Then(/^I see a popup window for download$/) do
	page.response_headers['Content-Disposition'].should include("rankings.csv")
end
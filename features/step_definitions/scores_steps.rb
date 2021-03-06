When(/^I follow poster #(\d+) "(.*?)"$/) do |arg1, arg2|
    #links = page.all(:link, arg2)
    #n = arg1.to_i - 1
    #links[n].click
    link = nil
    page.find('.table.table-bordered tbody tr', match: :first)
	page.all('.table.table-bordered tbody tr').each do |row|
	    cell = row.all('td').first
        if cell.text == arg1
            within(row) do
               link = page.find_link(arg2)
            end
            break
        end
    end
    link.click
    expect(page).to have_content("Details about Poster")
 end

Then(/^I should see an empty table "(.*?)"$/) do |arg1|
     wait_for_ajax
     rows = page.all(arg1 + " tbody tr")
     expect(rows.size).to eql 0
end


Then(/^I should see the following table "(.*?)":$/) do |arg1, expect_table|
	
	table_header = page.all(arg1 + " thead").map do |row|
	    row.all('th').map do |cell|
	        cell.text
	    end
    end
    
    # use find first is important for waiting for javascript function to run
    wait_for_ajax
    #page.find(arg1 +  " tbody tr", match: :first)
	table_body = page.all(arg1 +  " tbody tr").map do |row|
	    row.all('td').map do |cell|
	        cell.text
	    end
    end
    table_results = table_header + table_body
	   data = expect_table.raw
	   expect(table_results).to eq data
end



Then(/^Judge "(.*?)" set poster (\d) as "no_show"$/) do |arg1, arg2|
    judge = Judge.find_by(name: arg1)
	poster = Poster.find_by(:number => arg2)
	Score.assign_poster_to_judge(poster, judge)
	score = Score.find_by(judge_id: judge.id, poster_id: poster.id)
    score.update_attribute(:no_show, true)
end


Given(/^Judge "(.*?)" has not scored assigned poster (\d)$/) do |arg1, arg2|
    poster = Poster.where(:number => arg2).first()
    judge = Judge.where(:name => arg1).first()
    Score.assign_poster_to_judge(poster, judge)
end
Given(/^Judges scored posters as following:$/) do |table|
	table.hashes.each do |row|
		grade = row[:scores].split(',')
	    judge = Judge.where(:name => row[:name]).first()
		poster = Poster.where(:number =>row[:number]).first()
	    Score.assign_poster_to_judge(poster, judge)
	    score = Score.where(judge_id: judge.id, poster_id: poster.id).first()
	    score.update_attributes(:novelty =>grade[0], :utility =>grade[1], :difficulty =>grade[2], :verbal =>grade[3], :written =>grade[4])	
    end
end



When(/^I give new scores (.*?)$/) do |grade|
    expect(page).to have_content("Poster #")
    if grade == "No Show"
        click_button "No Show"
    else
        score = grade.split(",")
        expect(page).to have_button('Submit', disabled: true)
        score_terms = Score.score_terms
        i = 0
        score_terms.each do |term|
            choose(term+"#{score[i]}")
            i = i+1
        end
        click_button('Submit')
    end
end

When(/^I "(.*?)" the scores given by judge "(.*?)"$/) do |link_name, name|
    
    page.find(".table.table-bordered tbody tr", match: :first)
    expect(page).to have_content("Details about Poster")

    link = nil
    page.find('.table.table-bordered tbody tr', match: :first)
	page.all('.table.table-bordered tbody tr').each do |row|
	    row.all('td').each do |cell|
            if cell.text == name
                within(row) do
                   link = page.find_link(link_name)
                end
                break
            end
        end
    end
    link.click
end

Then(/^Judge "(.*?)" should have no scores$/) do |name|
    judge = Judge.find_by(name: name)
    expect(judge.scores.size).to eq 0
end


And(/^I create new score for judge "(.*?)"$/) do |code|
    fill_in("judge_code", :with => code)
    click_button "Create New Score"
end

Then(/^Button disappeared "(.*?)"$/) do |button|
     expect(page).not_to have_button("Accept Another Poster")
end
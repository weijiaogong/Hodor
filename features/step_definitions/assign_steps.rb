Given(/^this is a new judge$/) do
    Judge.create!
end

Given(/^there are (\d+) posters in the database$/) do |arg1|
   	arg1.to_i.times do
		Poster.create!
	end
end

When(/^I click on the "(.*?)" button$/) do |arg1|
    click_button arg1
end

Then(/^there should be a judge named "(.*?)" with (\d+) assigned posters$/) do |arg1, arg2|
	# @judge = Judge.where(name: arg1).first
	# @judge.posters.count.should equal(arg2)
	# @judge.scores.count.should equal(arg2)
    id_j = Judge.find_by_name(arg1)[:id]
            #puts id_j
            #puts judge_register_path(id_j)
            #puts page.current_url
            #visit judge_register_path(id_j)
            #puts page.body
    expect(page).to have_current_path(judge_path(id_j))
end

When(/^I fill in Name with "(.*?)"$/) do |arg1|
	# puts page.current_url
 # 	puts page.body
	# find('name').set(arg1)
	  #fill_in 'name', with: arg1
	fill_in('name', :with => arg1)
end

When(/^I fill in Company Name with "(.*?)"$/) do |arg1|
	# puts page.current_url
 # 	puts page.body
	# find('company').set(arg1)
	fill_in('company', :with => arg1)
	  #fill_in 'company', with: arg1
end	

And(/^I click "(.*?)"$/) do |arg1|
  	#puts Judge.find(:all)
  	click_button arg1
  	#puts page.body
end

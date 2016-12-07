require 'spec_helper'

def get_avg
  sum = 0
  Score.score_terms.each do |term| 
    sum += @scored.send(term)
  end
  avg = sum/Score.score_terms.size.to_f
  return avg
end

RSpec.describe "AdminScoresIndexPage" do
  before(:each) do
      @poster1 = FactoryGirl.create(:poster)
      @poster2 = FactoryGirl.create(:poster)
      @poster3 = FactoryGirl.create(:poster)
      @judge1  = FactoryGirl.create(:judge)
      @judge2  = FactoryGirl.create(:judge)
      @judge3  = FactoryGirl.create(:judge)
      
      @scored  = FactoryGirl.create(:scored, judge_name: @judge1.name, poster_number: @poster1.number)
      @unscored = FactoryGirl.create(:unscored, judge_name: @judge2.name, poster_number: @poster2.number)
      @no_show = FactoryGirl.create(:no_show, judge_name: @judge3.name, poster_number: @poster3.number)
      
      @scored11  = FactoryGirl.create(:scored, judge_name: @judge1.name, poster_number: @poster1.number)
      @scored12  = FactoryGirl.create(:scored, judge_name: @judge1.name, poster_number: @poster1.number)
      
      @unscored21 = FactoryGirl.create(:unscored, judge_name: @judge2.name, poster_number: @poster2.number)
      @no_show21 = FactoryGirl.create(:no_show, judge_name: @judge2.name, poster_number: @poster2.number)
      
      ApplicationController.any_instance.stub(:signed_in?).and_return(true)
      ApplicationController.any_instance.stub(:admin?).and_return(true)
      visit admin_scores_path
  end
  describe "Default Page" do
    it "should have the right layout" do
      current_path = URI.parse(current_url).path
      expect(current_path).to eq admin_scores_path
      expect(page).to have_selector('#status_all')
      expect(page).to have_selector('#status_no_show')
      expect(page).to have_selector('#status_undone')
      expect(page).to have_selector('#status_inprogress')
      expect(page).to have_selector('#status_completed')
      expect(page).to have_field('searchquery')
      expect(page).to have_button('Search')
      expect(page).to have_selector('#scores_table')
    end
    it "should list all posters with right status" do
      expect(page).to have_content(@poster1.title)
      expect(page).to have_content(@poster2.title)
      expect(page).to have_content(@poster3.title)
      expect(page).to have_content("%.3f" % get_avg)
      expect(page).to have_content("No Show")
    end
  end
  
   describe "filtered Page" do
        it "should only show undone posters", :js => true  do
          choose "status_undone"
          expect(page).not_to have_content(@poster1.title)
          expect(page).not_to have_content(@poster2.title)
          expect(page).to have_content(@poster3.title)
          expect(page).not_to have_content("%.3f" % get_avg)
          expect(page).to have_content("No Show")
        end
        it "should only show no_show posters", :js => true  do
          choose "status_no_show"
          expect(page).not_to have_content(@poster1.title)
          expect(page).to have_content(@poster2.title)
          expect(page).to have_content(@poster3.title)
          expect(page).not_to have_content("%.3f" % get_avg)
          expect(page).to have_content("No Show")
        end
        it "should only show inprogress posters", :js => true  do
          choose "status_inprogress"
          expect(page).not_to have_content(@poster1.title)
          expect(page).to have_content(@poster2.title)
          expect(page).not_to have_content(@poster3.title)
          expect(page).not_to have_content("%.3f" % get_avg)
          expect(page).not_to have_content("No Show")
        end
        it "should only show completed posters", :js => true  do
          choose "status_completed"
          expect(page).to have_content(@poster1.title)
          expect(page).not_to have_content(@poster2.title)
          expect(page).not_to have_content(@poster3.title)
          expect(page).to have_content("%.3f" % get_avg)
          expect(page).not_to have_content("No Show")
        end
    end
    
  describe "Search Page" do
    it "should show the right poster searching by poster number" do
      fill_in("searchquery", :with => @poster1.number.to_s)
      click_button("Search")
      expect(page).to have_content(@poster1.title)
      expect(page).not_to have_content(@poster2.title)
      expect(page).not_to have_content(@poster3.title)
      expect(page).to have_content("%.3f" % get_avg)
      expect(page).not_to have_content("No Show")
    end
    it "should show the right poster searching by poster id" do
      fill_in("searchquery", :with => @poster2.title)
      click_button("Search")
      expect(page).not_to have_content(@poster1.title)
      expect(page).to have_content(@poster2.title)
      expect(page).not_to have_content(@poster3.title)
      expect(page).not_to have_content("%.3f" % get_avg)
      expect(page).not_to have_content("No Show")
    end
  end
  describe "See detail Link" do
    it "should direct to show page" do
      first(:link, "See Details").click
      current_path = URI.parse(current_url).path
      expect(current_path).to eq admin_score_path(@poster1)
    end
  end
end
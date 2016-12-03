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
      @scored  = FactoryGirl.create(:scored)
      @poster1 = @scored.poster
      @judge1  = @scored.judge
      @unscored = FactoryGirl.create(:unscored)
      @poster2  = @unscored.poster
      @judge2   = @unscored.judge
      @no_show = FactoryGirl.create(:no_show)
      @poster3 = @no_show.poster
      @judge3  = @no_show.judge
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
      expect(page).to have_selector('#status_scored')
      expect(page).to have_selector('#status_unscored')
      expect(page).to have_field('searchquery')
      expect(page).to have_button('Search')
      expect(page).to have_selector('#scores_table')
    end
    it "should list all posters with right status" do
      expect(page).to have_content(@poster1.title)
      expect(page).to have_content(@poster2.title)
      expect(page).to have_content(@poster3.title)
      expect(page).to have_content("%.3f" % get_avg)
      expect(page).to have_content("-")
      expect(page).to have_content("No Show")
    end
  end
  
   describe "filtered Page" do
        it "should only show scored posters", js: true do
          choose("status_scored")
          expect(page).to have_content(@poster1.title)
          expect(page).not_to have_content(@poster2.title)
          expect(page).not_to have_content(@poster3.title)
          expect(page).to have_content("%.3f" % get_avg)
          expect(page).not_to have_content("-")
          expect(page).not_to have_content("No Show")
        end
        it "should only show unscored posters", :js => true  do
          choose "status_unscored"
          expect(page).not_to have_content(@poster1.title)
          expect(page).to have_content(@poster2.title)
          expect(page).not_to have_content(@poster3.title)
          expect(page).not_to have_content("%.3f" % get_avg)
          expect(page).to have_content("-")
          expect(page).not_to have_content("No Show")
        end
        it "should only show no_show posters", :js => true  do
          choose "status_no_show"
          expect(page).not_to have_content(@poster1.title)
          expect(page).not_to have_content(@poster2.title)
          expect(page).to have_content(@poster3.title)
          expect(page).not_to have_content("%.3f" % get_avg)
          expect(page).not_to have_content("-")
          expect(page).to have_content("No Show")
        end
    end
    
  describe "Search Page" do
    it "should show the right poster searching by poster id" do
      fill_in("searchquery", :with => @poster1.number.to_s)
      click_button("Search")
      expect(page).to have_content(@poster1.title)
      expect(page).not_to have_content(@poster2.title)
      expect(page).not_to have_content(@poster3.title)
      expect(page).to have_content("%.3f" % get_avg)
      expect(page).not_to have_content("-")
      expect(page).not_to have_content("No Show")
    end
    it "should show the right poster searching by poster id" do
      fill_in("searchquery", :with => @poster2.title)
      click_button("Search")
      expect(page).not_to have_content(@poster1.title)
      expect(page).to have_content(@poster2.title)
      expect(page).not_to have_content(@poster3.title)
      expect(page).not_to have_content("%.3f" % get_avg)
      expect(page).to have_content("-")
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
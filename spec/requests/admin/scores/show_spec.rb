require 'spec_helper'

def get_avg
  sum = 0
  Score.score_terms.each do |term| 
    sum += @scored.send(term)
  end
  avg = sum/Score.score_terms.size.to_f
  return avg
end

RSpec.describe "AdminScoresShowPage" do
  before(:each) do
      @scored  = FactoryGirl.create(:scored)
      @poster1 = @scored.poster
      @judge1  = @scored.judge
      ApplicationController.any_instance.stub(:signed_in?).and_return(true)
      ApplicationController.any_instance.stub(:admin?).and_return(true)
      visit admin_score_path(@poster1)
  end
  describe "Default Page" do
    it "should have the right layout" do
      current_path = URI.parse(current_url).path
      expect(current_path).to eq admin_score_path(@poster1)
      expect(page).to have_link('Edit')
      expect(page).to have_link('Delete')
      expect(page).to have_selector('#details_table')
      expect(page).to have_button("Back")
      expect(page).to have_button("Create New Score")
    end
    it "should list all scores for the poster" do
      expect(page).to have_content(@poster1.title)
      expect(page).to have_content(@judge1.name)
      expect(page).to have_content("%.3f" % get_avg)
    end
  end
 
  describe "Edit Link" do
    it "should direct to show page" do
      first(:link, "Edit").click
      current_path = URI.parse(current_url).path
      expect(current_path).to eq edit_admin_score_path(@scored)
    end
  end
end
require "spec_helper"

RSpec.describe  ScoresController, type: "controller" do
  describe 'update' do
    before(:each) do
        @poster1 = FactoryGirl.create(:poster)
        
        @judge1  = FactoryGirl.create(:judge)
        @unscored = FactoryGirl.create(:unscored, judge_name: @judge1.name, poster_number: @poster1.number)
        visit edit_judge_score_path(@judge1.id, @poster1.id)
        ApplicationController.any_instance.stub(:signed_in?).and_return(true)
        @scorezero = Hash.new
        Score.score_terms.each do |term|
          @scorezero[term.to_sym] = "0"
        end
    end
    context "invalid scores" do
        it "redirect to  edit page" do
            put :update, :score => @scorezero, :judge_id => @judge1.id, :poster_id => @poster1.id
            expect(assigns(:score)).to eq @unscored
            expect(response).to redirect_to edit_judge_score_path(@judge1.id, @poster1.id)
        end
    end
  end
end
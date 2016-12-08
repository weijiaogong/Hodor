require 'spec_helper'

describe Score do
    let(:poster) {FactoryGirl.build(:poster) }
    let(:judge) {FactoryGirl.build(:judge) }
    
    describe "new score" do
        it "assign a poster to  one judge successfull " do
            Score.assign_poster_to_judge(poster, judge)
            score = Score.find_by(poster_id: poster.id, judge_id: judge.id)
            expect(score).to be_valid
        end
    end
    describe "attributes accessbile" do
        it "should return the arrary of score term names" do
           terms = ["novelty", "utility", "difficulty", "verbal", "written"]
           expect(Score.score_terms).to eq terms
        end
        let(:score) {FactoryGirl.build(:unscored)}
        subject{score}
    	it { should respond_to(:novelty) }
    	it { should respond_to(:utility) }
        it { should respond_to(:difficulty) }
        it { should respond_to(:verbal) }
        it { should respond_to(:written) }
        it { should respond_to(:no_show) }
        it {should respond_to(:poster) }
        it {should respond_to(:judge) }
        it { should be_valid }
    end
    describe "get total score" do
        let(:score) {FactoryGirl.create(:scored)}
        subject{score}
        it "return the sum" do
            sumscore = Score.get_score_sum.find(score.id)
            score_sum = score.novelty + score.utility +
                        score.difficulty + score.verbal + score.written
            expect(sumscore.score_sum).to eq score_sum
        end
            
    end
end
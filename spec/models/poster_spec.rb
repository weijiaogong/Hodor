require 'spec_helper'

describe Poster do
    describe "new" do
        context "given title, students, advisor, and email" do
            it "creates a new poster" do
                poster = Poster.new(:title=> :title, :presenter=> :presenter, :advisors=> :advisors, :email=> :email)
            
                expect(poster.title).to eq "title"
                expect(poster.presenter).to eq "presenter"
                expect(poster.advisors).to eq "advisors"
                expect(poster.email).to eq "email"
            end
        end
    end
    
    describe "import_csv" do
        it "rejects unknown parameters" do
            expect(Poster.import([{:bad => :bad}])).to eq "Invalid column header- valid options are presenter, title, advisors, email"
        end
            
    end
end
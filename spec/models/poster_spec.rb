require 'spec_helper'

describe Poster do
    describe "new" do
        context "given title, students, advisor, and email" do
            it "creates a new poster" do
                poster do
                    Poster.new(:title=> :title, :student=> :student, :advisor=> :advisor, :email=> email)
                end
            
                expect(poster.title).to eq :title
                expect(poster.student).to eq :student
                expect(poster.advisor).to eq :advisor
                expect(poster.email).to eq :email
            end
        end
    end
    
    describe "import_csv" do
        it "rejects unknown parameters" do
            expect(Poster.import([{:bad => :bad}])).to eq "Invalid column header- valid options are number, presenter, title, advisors, email"
        end
        
        it "expects all needed parameters" do
        end
    end
end
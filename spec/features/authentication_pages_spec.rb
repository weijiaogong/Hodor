require 'spec_helper'

describe "Authentication" do

  subject { page }

  describe "signin page" do
    before { visit signin_path }

    describe "with invalid information" do
      before { click_button "Sign in" }
      it { should have_button('Sign in') }
      it { should have_title('PosterJudging') }
      it { should have_content('Invalid') }
    end

  end
end

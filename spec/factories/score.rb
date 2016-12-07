FactoryGirl.define do
	factory :score, class: 'Score' do
	  trait(:unscored){
		  novelty -1
		  utility -1
		  difficulty -1
		  verbal -1
		  written -1
	  }
	  trait(:scored){
		  novelty 5
		  utility 5
		  difficulty 5
		  verbal 5
		  written 5
	  }
	  
	  transient do
	    judge_name "Bill"
	    poster_number 1
	  end
	 
	  judge do
	    Judge.find_by(name: judge_name) || FactoryGirl.create(:judge, name: judge_name)
	  end

      poster do
      	Poster.find_by(number: poster_number) ||  FactoryGirl.create(:poster, number: poster_number)
      end
	  trait(:no_show) {no_show true}
	  trait(:show) {no_show false}
	  
	  factory :unscored, traits: [:unscored, :show]
	  factory :scored, traits: [:scored, :show]
	  factory :no_show, traits: [:unscored, :no_show]
	end
end

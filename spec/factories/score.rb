FactoryGirl.define do
	factory :score, class: 'Score' do
	  association :poster
	  association :judge
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
	  after :create  do |score|
	  	poster = score.poster
	  	judge  = score.judge
	  	poster.save
	  	judge.save
	  end
	  trait(:no_show) {no_show true}
	  trait(:show) {no_show false}
	  
	  factory :unscored, traits: [:unscored, :show]
	  factory :scored, traits: [:scored, :show]
	  factory :no_show, traits: [:unscored, :no_show]
	end
end

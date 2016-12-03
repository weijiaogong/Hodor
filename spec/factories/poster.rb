FactoryGirl.define do 
	factory :poster, class: 'Poster'  do
	  sequence(:number) { |n| n }
	  sequence(:title) { |n|   "Dragon#{n}" }
	  sequence(:presenter) { |n|  "Bill#{n}" }
	  sequence(:advisors) { |n|  "Grant#{n}" }
	  sequence(:email) { |n|  "bill#{n}@tamu.edu" }
	end
end

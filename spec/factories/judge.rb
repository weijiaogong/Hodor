FactoryGirl.define do
	factory :judge, class: 'Judge'  do
	  sequence(:name) { |n|  "Grant#{n}"}
	  company_name "tamu"
	  sequence(:access_code) { |n|  "grant#{n}"}
	  sequence(:role) { |n|  "judge#{n}"}
	end
end

class Judge < ActiveRecord::Base
	attr_accessible :name, :company_name, :access_code
	has_many :scores
	has_many :posters, through: :scores
end

class Poster < ActiveRecord::Base
	has_many :scores, dependent: :destroy
	has_many :judges, through: :scores
	validates :presenter, :email, :title, :advisors, presence: true
	#validates :number, uniqueness: true # not sure whether the number should be unique
	
	
	def self.import_csv(file)
		CSV.foreach(file.path, headers: true, encoding: 'windows-1251:utf-8') do |row|
			posters = Poster.where(number: row['number'])
			row_hash = row.to_hash
			if posters.count == 1
			   poster = posters.first
			   poster.assign_attributes(row_hash)	#FIXME ensure attributes are valid
               poster.save!(validate: false)
			else
				newposter = Poster.new(row_hash)	#FIXME ensure attributes are valid
				newposter.save!(validate: false)
			end
		end
	end

	def self.find_least_judged()
		Poster.where("no_show = false AND scores_count < 3")
	end
	
	def self.all_scored
	  Poster.where("no_show = false AND scores_count > 0")
	end
	
	def self.find_by_keywords(keywords)
			keywords = keywords.gsub(/^/, '%').gsub(/$/, '%')
	        Poster.where('title LIKE ?', keywords)
	end
end

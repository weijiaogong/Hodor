class Poster < ActiveRecord::Base
	has_many :scores, dependent: :destroy
	has_many :judges, through: :scores
	validates :presenter, :email, :title, :advisors, presence: true
	#validates :number, uniqueness: true # not sure whether the number should be unique
	
	
	def self.import(data)
		data.each do |row|
			#FIXME DRY by getting attrs?
			if row.to_hash.keys.any? {|k| not(["number", "presenter", "title", "advisors", "email"].include?(k))}	#TODO DRY this out
				return "Invalid column header- valid options are number, presenter, title, advisors, email"
			end
			poster = Poster.where(number: row['number']).first
			row_hash = row.to_hash.keep_if {|k,v| ["number", "presenter", "title", "advisors", "email"].include?(k)}

			if not poster.nil?
				poster.update_attributes(row_hash)
			else
				poster = Poster.create(row_hash)
			end

		end
		return "Import successful"
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

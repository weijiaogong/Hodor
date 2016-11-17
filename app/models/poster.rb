class Poster < ActiveRecord::Base

	has_many :scores, dependent: :destroy
	has_many :judges, through: :scores
	validates :presenter, :email, :title, :advisors, presence: true
	#validates :number, uniqueness: true # not sure whether the number should be unique
	
	
	def self.import(data)
		data.each do |row|
			if row.to_hash.keys.any? {|k| not(["number", "presenter", "title", "advisors", "email"].include?(k))}
				return "Invalid column header- valid options are number, presenter, title, advisors, email"
			end
			
			if not row.to_hash.keys.all? {|k| (["number", "presenter", "title", "advisors", "email"].include?(k))}
				return "Missing column header- presenter, title, advisors, email are required"
			end
			
			row_hash = row.to_hash
			
			#if title or presenter both change, we don't know if we have an old poster, so assume a new one
			poster = Poster.where("presenter = ? or title = ?", row_hash["presenter"], row_hash["title"]).first	#protip/note to self: :presenter not eq "presenter"

			if not poster.nil?
				poster.update_attributes(row_hash)	#FIXME autonumbering will be overriden
			else
				poster = Poster.create(row_hash.merge({:number => Poster.count + 1}))	#FIXME fail if missing field
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
	        Poster.where('lower(title) LIKE ?', keywords.downcase)
	end
end

class Poster < ApplicationRecord

	has_many :scores, dependent: :destroy
	has_many :judges, through: :scores
	validates :presenter, :email, :title, :advisors, presence: true
	validates :number, uniqueness: true
	
	
	def self.import(data)
		data.each do |row|
			row_hash = row.to_hash
			if row_hash.keys.any? {|k| not(["presenter", "title", "advisors", "email"].include?(k))}
				return "Invalid column header- valid options are presenter, title, advisors, email"
			end
			
			if not ["presenter", "title", "advisors", "email"].all? {|k| (row_hash.keys.include?(k))}
				return "Missing column header- presenter, title, advisors, email are required"
			end
			
			#if title or presenter both change, we don't know if we have an old poster, so assume a new one
			poster = Poster.where("presenter = ? or title = ?", row_hash["presenter"], row_hash["title"]).first	#protip/note to self: :presenter not eq "presenter"

			if not poster.nil?
				poster.update_attributes(row_hash)
			elsif Poster.count < Event.find(1).max_poster_number	#we could have duplicated posters, so we check if we still have room one poster at a time
				poster = Poster.create(row_hash.merge({:number => Poster.count + 1}))
				if not poster.errors.messages.empty?
					return "Missing fields- please make sure all entries are not blank"
				end
			else
				return "Error: Exceeding poster limit"
			end
			
			# Send Confirmation email to all the posters in the csv file uploaded
			RemindMailer.confirmation_email(row_hash).deliver_later
		end
		
		return "Import successful"
	end

	def self.find_least_judged()
		#Poster.where("no_show = false AND scores_count < 3")
		Poster.where("scores_count < 3")
	end
=begin	
	def self.all_scored
		posters = Poster.where("scores_count > 0")
		posters.each do |poster|
		    scored = false
			poster.scores.each do |score|
				if score.send(Score.score_terms[0]) > 0
					scored = true
					break
				end
			end
            unless scored
				posters = posters.reject {|p| p.id == poster.id}
            end
		end
	end
=end
	
	def self.find_by_keywords(keywords)
			keywords = keywords.gsub(/^/, '%').gsub(/$/, '%')
	        Poster.where('lower(title) LIKE ?', keywords.downcase)
	end
end

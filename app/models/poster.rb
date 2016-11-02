class Poster < ActiveRecord::Base
	#attr_accessible :number, :presenter, :title, :advisors, :scores_count, :email
	has_many :scores, dependent: :destroy
	has_many :judges, through: :scores

	def self.import_csv(file)
		CSV.foreach(file.path, headers: true, encoding: 'windows-1251:utf-8') do |row|
			poster = Poster.where(number: row['number'])
			row_hash = row.to_hash
			if poster.count == 1
				poster.first.update_attributes(row_hash)
			else
				Poster.create(row_hash)
			end
		end
	end

	def self.find_least_judged()
		return Poster.where("scores_count < 3").sample(3)
	end
end

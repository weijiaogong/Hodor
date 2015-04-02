class CreatePosters < ActiveRecord::Migration
  	def up
		create_table :posters do |t|
			t.integer :number
			t.string :presenter
			t.string :title
			t.string :advisors #multiple advisors should be seperated by commas
			t.integer :score, default: 0
			t.integer :judges, default: 0 #number of judges assigned to this specific poster
		end
  	end

  	def down
		drop_table :posters
  	end
end

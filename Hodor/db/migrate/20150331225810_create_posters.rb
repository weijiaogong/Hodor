class CreatePosters < ActiveRecord::Migration
  	def up
		create_table :posters do |t|
			t.integer :number
			t.string :presenter
			t.string :title
			t.string :advisors
			t.integer "scores_count", default: 0 
		end
  	end

  	def down
		drop_table :posters
  	end
end

class CreateScores < ActiveRecord::Migration
	def up
		create_table :scores do |t|
			t.integer :novelty
			t.integer :utility
			t.integer :difficulty
			t.integer :verbal
			t.integer :written
			t.boolean :no_show, default: false
			t.belongs_to :poster, index: true
			t.belongs_to :judge, index: true
		end
  	end

  	def down
		drop_table :scores
  	end
end

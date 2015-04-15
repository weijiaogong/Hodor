class CreateJudges < ActiveRecord::Migration
	def up
		create_table :judges do |t|
			t.string :name
			t.string :company_name
            t.string :access_code
			t.integer "scores_count", default: 0
		end
  	end

  	def down
		drop_table :judges
  	end
end

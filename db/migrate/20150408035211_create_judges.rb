class CreateJudges < ActiveRecord::Migration
	def up
		create_table :judges do |t|
			t.string :name
			t.string :company_name
            t.string :access_code
		end
  	end

  	def down
		drop_table :judges
  	end
end

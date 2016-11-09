class CreateEvents < ActiveRecord::Migration
  def change
		  create_table :events do |t|
			  
			  t.string :day
			  t.string :month
			  t.string :year
			  
		  end
  end
end

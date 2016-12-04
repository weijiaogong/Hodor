class AddMaxPosterNumberToEvents < ActiveRecord::Migration[5.0]
  def change
    add_column :events, :max_poster_number, :integer
  end
end

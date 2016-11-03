class AddNoshowToPosters < ActiveRecord::Migration[5.0]
  def change
    add_column :posters, :no_show, :boolean, :default => false
  end
end

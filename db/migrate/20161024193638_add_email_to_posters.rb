class AddEmailToPosters < ActiveRecord::Migration
  def change
    add_column :posters, :email, :string
  end
end

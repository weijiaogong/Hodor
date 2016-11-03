class RemoveNoshowFromScores < ActiveRecord::Migration[5.0]
  def change
    remove_column :scores, :no_show, :boolean
  end
end

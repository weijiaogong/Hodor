class AddLeaveToJudges < ActiveRecord::Migration[5.0]
  def change
    add_column :judges, :leave, :boolean, :default => false
  end
end

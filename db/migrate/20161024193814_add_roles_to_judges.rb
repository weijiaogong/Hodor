class AddRolesToJudges < ActiveRecord::Migration
  def change
    add_column :judges, :role, :string
  end
end

class AddRememberTokenToJudges < ActiveRecord::Migration
  def change
    add_column :judges, :remember_token, :string
    add_index  :judges, :remember_token
  end
end

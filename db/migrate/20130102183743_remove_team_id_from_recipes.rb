class RemoveTeamIdFromRecipes < ActiveRecord::Migration
  def change
    remove_column :recipes, :team_id
  end
end

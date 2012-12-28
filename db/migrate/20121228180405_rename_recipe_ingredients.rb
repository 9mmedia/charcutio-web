class RenameRecipeIngredients < ActiveRecord::Migration
  def change
    remove_column :recipe_ingredients, :ingredient_id
    rename_table :recipe_ingredients, :ingredients
  end
end

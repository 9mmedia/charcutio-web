class CreateRecipeIngredient < ActiveRecord::Migration
  def change
    create_table(:recipe_ingredients) do |t|
      t.string :name
      t.integer :ingredient_id
      t.integer :recipe_id
      t.decimal :recipe_weight_percentage
      t.decimal :water_percentage
      t.timestamps
    end
  end
end

class StorePercentagesAsIntegers < ActiveRecord::Migration
  def change
    change_column :ingredients, :recipe_weight_percentage, :integer
    change_column :ingredients, :water_percentage, :integer
    change_column :recipes, :initial_water_percentage, :integer
    change_column :recipes, :fermentation_humidity, :integer
    change_column :recipes, :default_drying_humidity, :integer
  end
end

class AddAttributesToRecipe < ActiveRecord::Migration
  def change
    add_column :recipes, :fermentation_temperature, :integer
    add_column :recipes, :fermentation_humidity, :decimal
    add_column :recipes, :default_drying_temperature, :integer
    add_column :recipes, :default_drying_humidity, :decimal
  end
end

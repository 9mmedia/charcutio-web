class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :recipe_weight_percentage,
    presence: true
  validates :water_percentage,
    presence: true

  after_save :update_recipe_water_percentage

  def update_recipe_water_percentage
    recipe.update_water_percentage
  end
end

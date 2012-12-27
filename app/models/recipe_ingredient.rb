class RecipeIngredient < ActiveRecord::Base
  belongs_to :recipe
  belongs_to :ingredient

  validates :recipe_weight_percentage,
    presence: true
  validates :water_percentage,
    presence: true

  before_validation :copy_water_percentage_and_name

  def copy_water_percentage_and_name
    if ingredient.present?
      self.water_percentage ||= ingredient.water_percentage
      self.name ||= ingredient.name
    end
  end
end

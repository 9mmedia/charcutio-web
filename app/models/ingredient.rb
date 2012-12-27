class Ingredient < ActiveRecord::Base
  has_many :recipe_ingredients

  validates :water_percentage,
    presence: true
end

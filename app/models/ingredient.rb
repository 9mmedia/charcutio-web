class Ingredient < ActiveRecord::Base
  belongs_to :recipe

  validates :recipe_weight_percentage,
    presence: true
  validates :water_percentage,
    presence: true
end

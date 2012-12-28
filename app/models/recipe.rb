class Recipe < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :ingredients

  accepts_nested_attributes_for :ingredients,
    allow_destroy: true

  def update_water_percentage
    total = 0
    ingredients.each do |ingredient|
      total += ingredient.recipe_weight_percentage * ingredient.water_percentage
    end
    update_attributes initial_water_percentage: total
  end
end

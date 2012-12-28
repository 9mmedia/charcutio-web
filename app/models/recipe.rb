class Recipe < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :ingredients

  validates :initial_water_percentage,
    presence: true

  before_validation :set_initial_water_percentage

  def set_initial_water_percentage
    total = 0
    recipe_ingredients.each do |ingredient|
      total += ingredient.recipe_weight_percentage * ingredient.water_percentage
    end
    self.initial_water_percentage = total
  end
end

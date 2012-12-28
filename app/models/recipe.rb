class Recipe < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :ingredients,
    dependent: :destroy

  accepts_nested_attributes_for :ingredients,
    allow_destroy: true

  after_save :add_ingredients,
    if: :ingredients_changed?

  def add_ingredients
    @ingredients_attributes.each do |key, ingredient_params|
      create_ingredients ingredient_params
    end
    update_water_percentage
  end

  def ingredients_changed?
    @ingredients_attributes
  end

  def update_water_percentage
    total = 0
    ingredients.reload.each do |ingredient|
      total += ingredient.recipe_weight_percentage * ingredient.water_percentage
    end
    update_attributes initial_water_percentage: total
  end
end

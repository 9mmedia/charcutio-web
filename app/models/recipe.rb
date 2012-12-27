class Recipe < ActiveRecord::Base
  belongs_to :team
  belongs_to :user
  has_many :meats
  has_many :recipe_ingredients
end

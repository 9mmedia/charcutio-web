require 'spec_helper'

describe RecipeIngredient do
  describe 'validations' do
    it { should validate_presence_of(:recipe_weight_percentage) }
    it { should validate_presence_of(:water_percentage) }
  end

  describe 'associations' do
    it { should belong_to(:ingredient) }
    it { should belong_to(:recipe) }
  end
end

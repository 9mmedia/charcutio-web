require 'spec_helper'

describe Ingredient do
  describe 'validations' do
    it { should validate_presence_of(:water_percentage) }
  end

  describe 'associations' do
    it { should have_many(:recipe_ingredients) }
  end
end

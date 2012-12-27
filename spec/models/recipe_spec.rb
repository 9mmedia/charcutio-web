require 'spec_helper'

describe Recipe do
  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:user) }
    it { should have_many(:meats) }
    it { should have_many(:recipe_ingredients) }
  end
end

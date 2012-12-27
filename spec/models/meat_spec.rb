require 'spec_helper'

describe Meat do

  describe 'associations' do
    it { should belong_to(:box) }
    it { should belong_to(:team) }
    it { should belong_to(:user) }
    it { should belong_to(:recipe) }
  end

  describe '#current_water_percentage' do
    it "calculates the meat's current water percentage given its current weight" do
      meat = Meat.new(initial_weight: 100.0)
      meat.recipe = Recipe.new(initial_water_percentage: 0.8)

      meat.current_water_percentage('90').round(2).should == 0.78
    end
  end
end

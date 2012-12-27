require 'spec_helper'

describe Meat do

  describe 'associations' do
    it { should belong_to(:box) }
    it { should belong_to(:team) }
    it { should belong_to(:user) }
    it { should belong_to(:recipe) }
  end
end

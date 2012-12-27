require 'spec_helper'

describe User do
  describe 'associations' do
    it { should have_many(:boxes) }
    it { should have_many(:meats) }
    it { should have_many(:teams) }
  end
end

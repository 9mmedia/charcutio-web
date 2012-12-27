require 'spec_helper'

describe Team do
  describe 'associations' do
    it { should have_many(:boxes) }
    it { should have_many(:meats) }
    it { should have_many(:users) }
  end
end

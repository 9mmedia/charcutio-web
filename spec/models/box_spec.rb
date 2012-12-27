require 'spec_helper'

describe Box do
  describe 'associations' do
    it { should have_many(:meats) }
    it { should belong_to(:team) }
    it { should belong_to(:master_meat) }
  end
end

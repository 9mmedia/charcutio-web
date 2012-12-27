require 'spec_helper'

describe Teammate do
  describe 'associations' do
    it { should belong_to(:team) }
    it { should belong_to(:user) }
  end
end

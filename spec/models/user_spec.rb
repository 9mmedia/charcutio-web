require 'spec_helper'

describe User do

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:email) }
    #it { should validate_uniqueness_of(:email).case_insensitive }

    it "validates email uniqueness" do
      user = FactoryGirl.build :user
      user.save
      expect(user).to validate_uniqueness_of :email
    end

    it { should validate_presence_of(:password) }
  end

  describe '#create' do
    it 'generates auth token' do
      user = FactoryGirl.create :user
      expect(user.auth_token.present?).to be_true
      user.reload
      expect(user.auth_token.present?).to be_true
    end
  end

end

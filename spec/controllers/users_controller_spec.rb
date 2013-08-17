require 'spec_helper'

describe UsersController do

  describe '#create' do
    context 'given valid user attributes' do
      it 'creates a new user' do
        attrs = FactoryGirl.attributes_for(:user)

        expect(User.count).to eql(0)

        xhr :post, :create, user: attrs

        expect(response).to be_success
        expect(User.count).to eql(1)
      end
    end

    context 'given invalid user attributes' do
      it 'returns an error response' do
        attrs = FactoryGirl.attributes_for(:user, name: nil)

        expect(User.count).to eql(0)

        xhr :post, :create, user: attrs

        expect(response.code).to eql('422')
        expect(User.count).to eql(0)
      end
    end
  end

end

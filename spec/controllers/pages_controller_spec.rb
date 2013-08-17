require 'spec_helper'

describe PagesController do

  render_views

  describe '#index' do
    it 'renders the index template' do
      get :index

      expect(response).to be_success
      expect(response).to render_template('index')
    end
  end

end

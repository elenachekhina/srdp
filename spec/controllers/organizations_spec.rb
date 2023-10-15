# frozen_string_literal: true

require 'rails_helper'

RSpec.describe OrganizationsController, type: :controller do
  describe 'GET /index' do
    let(:organizations) { create_list(:organization, 3) }

    before { get :index }

    it 'renders index view' do
      expect(response).to render_template :index
    end
  end
end

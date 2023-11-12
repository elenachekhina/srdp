# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Organizations', type: :request do
  let(:headers) { { 'HTTP_HOST' => 'localhost' } }

  describe 'GET /organizations' do
    it 'return ok status' do
      get(organizations_path, headers:)
      expect(response).to have_http_status(200)
    end

    it 'render index template' do
      get(organizations_path, headers:)
      expect(response).to render_template(:index)
    end
  end

  describe 'GET /organizations/:id' do
    let(:organization) { create(:organization) }

    it 'return ok status' do
      get(organization_path(organization), headers:)
      expect(response).to have_http_status(200)
    end

    it 'render show template' do
      get(organization_path(organization), headers:)
      expect(response).to render_template(:show)
    end
  end
end

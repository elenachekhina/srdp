# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Org::Organizations', type: :request do
  let(:organization) { create(:organization) }
  let!(:address) { create(:address, organization:) }

  describe 'GET #show' do
    context 'when authenticated' do
      before do
        login(organization)
        get org_organization_path(organization),
            headers: { 'HTTP_HOST' => 'org.localhost' }
      end

      it 'renders the show template' do
        expect(response.body).to render_template(:show)
      end
    end
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get new_org_organization_path,
          headers: { 'HTTP_HOST' => 'org.localhost' }
      expect(response.body).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:organization) } # from FactoryBot

      it 'creates a new org' do
        expect do
          post org_organizations_path(params: { organization: valid_attributes }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.to change(Organization, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { name: '', email: '', password: '' } }

      it 'does not create a new org' do
        expect do
          post org_organizations_path(params: { organization: invalid_attributes }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.not_to change(Organization, :count)
      end
    end
  end
end

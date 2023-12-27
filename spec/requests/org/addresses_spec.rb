# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Org::Addresses', type: :request do
  let(:organization) { create(:organization) }
  before { login(organization) }

  describe 'GET #new' do
    before do
      get new_org_organization_address_path(organization_id: organization.id),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new view' do
      expect(response.body).to render_template('org/addresses/_form')
    end
  end

  describe 'POST #create' do
    context 'With valid attr' do
      it 'Creates a new address' do
        expect do
          post org_organization_addresses_path(organization,
                                               params: { address: attributes_for(:address), format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.to change(Address.all, :count).by(1)
      end
    end

    context 'With invalid attr' do
      it 'Does not create a new address' do
        expect do
          post org_organization_addresses_path(organization,
                                               params: { address: attributes_for(:address, :invalid_address),
                                                         format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.not_to change(Address.all, :count)
      end
    end
  end

  describe 'GET #edit' do
    let(:address) { create(:address, organization:) }

    before do
      get edit_org_address_path(address),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit address form' do
      expect(response.body).to render_template('org/addresses/_edit')
    end
  end

  describe 'PATCH #update' do
    let(:address) { create(:address, organization:) }

    context 'With valid attr' do
      it 'Updates address' do
        patch org_address_path(address,
                               params: { address: attributes_for(:address, street: 'new street'),
                                         format: :turbo_stream }),
              headers: { 'HTTP_HOST' => 'org.localhost' }

        expect(address.reload.street).to eq('new street')
      end
    end

    context 'With invalid attr' do
      it 'Does not update address' do
        patch org_address_path(address,
                               params: { address: attributes_for(:address, :invalid_address), format: :turbo_stream }),
              headers: { 'HTTP_HOST' => 'org.localhost' }

        expect(address.reload.street).to eq(address.street)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:address) { create(:address, organization:) }

    it 'Deletes the address' do
      expect do
        delete org_address_path(address),
               headers: { 'HTTP_HOST' => 'org.localhost' }
      end.to change(Address.all, :count).by(-1)
    end
  end
end

# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Org::Services', type: :request do
  include_context "mocked MeilisearchService"

  let(:organization) { create(:organization) }
  before { login(organization) }

  describe 'GET #new' do
    before do
      get new_org_organization_service_path(organization_id: organization.id),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new view' do
      expect(response.body).to render_template(partial: '_new')
    end
  end

  describe 'POST #create' do
    context 'With valid attr' do
      it 'Creates a new service' do
        expect do
          post org_organization_services_path(organization,
                                              params: { service: attributes_for(:service), format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.to change(Service.all, :count).by(1)
      end
    end

    context 'With invalid attr' do
      it 'Does not create a new service' do
        expect do
          post org_organization_services_path(organization,
                                              params: { service: attributes_for(:service, :invalid_service),
                                                        format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
        end.not_to change(Service.all, :count)
      end
    end
  end

  describe 'GET #edit' do
    let(:service) { create(:service, organization:) }

    before do
      get edit_org_service_path(service),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit service form' do
      expect(response.body).to render_template(partial: '_edit')
    end
  end

  describe 'PUT #update' do
    let(:service) { create(:service, organization:) }

    context 'With valid attributes' do
      it 'Changes service' do
        patch org_service_path(service,
                               params: { service: attributes_for(:service, name: 'New name'), format: :turbo_stream }),
              headers: { 'HTTP_HOST' => 'org.localhost' }
        service.reload
        expect(service.name).to eq('New name')
      end
    end

    context 'With invalid attributes' do
      it 'Does not change service' do
        old_name = service.name
        patch org_service_path(service,
                               params: { service: attributes_for(:service, name: ''), format: :turbo_stream }),
              headers: { 'HTTP_HOST' => 'org.localhost' }
        service.reload
        expect(service.name).to eq(old_name)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:service) { create(:service, organization:) }

    it 'Deletes a service' do
      expect do
        delete org_service_path(service, params: { format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }
      end.to change(Service.all, :count).by(-1)
    end
  end
end

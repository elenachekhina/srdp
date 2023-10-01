# spec/controllers/org/organizations_controller_spec.rb
require 'rails_helper'

RSpec.describe Org::OrganizationsController, type: :controller do
  let(:organization) { create(:organization) }

  describe 'GET #show' do
    context 'when authenticated' do
      before do
        session[:organization_id] = organization.id
        get :show, params: { id: organization.id }
      end

      it 'renders the show template' do
        expect(response).to render_template(:show)
      end
    end

    # Add tests for unauthenticated access if needed
  end

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid attributes' do
      let(:valid_attributes) { attributes_for(:organization) }  # from FactoryBot

      it 'creates a new organization' do
        expect {
          post :create, params: { organization: valid_attributes }
        }.to change(Organization, :count).by(1)
      end

      it 'redirects to the root path' do
        post :create, params: { organization: valid_attributes }
        expect(response).to redirect_to(root_path)
      end
    end

    context 'with invalid attributes' do
      let(:invalid_attributes) { { name: '', email: '', password: '' } }

      it 'does not create a new organization' do
        expect {
          post :create, params: { organization: invalid_attributes }
        }.not_to change(Organization, :count)
      end

      it 're-renders the new template' do
        post :create, params: { organization: invalid_attributes }
        expect(response).to render_template(:new)
      end
    end
  end
end

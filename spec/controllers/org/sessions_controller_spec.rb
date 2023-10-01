# spec/controllers/org/sessions_controller_spec.rb
require 'rails_helper'

RSpec.describe Org::SessionsController, type: :controller do
  let(:organization) { create(:organization) }

  describe 'GET #new' do
    it 'renders the new template' do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        post :create, params: { session: { email: organization.email, password: organization.password } }
      end

      it 'sets the organization id in session' do
        expect(session[:organization_id]).to eq(organization.id)
      end

      it 'redirects to the organization page' do
        expect(response).to redirect_to(org_organization_path(organization))
      end
    end

    context 'with invalid credentials' do
      before do
        post :create, params: { session: { email: organization.email, password: 'wrong_password' } }
      end

      it 'does not set the organization id in session' do
        expect(session[:organization_id]).to be_nil
      end

      it 're-renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      session[:organization_id] = organization.id
      delete :destroy
    end

    it 'resets the organization id in session' do
      expect(session[:organization_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end

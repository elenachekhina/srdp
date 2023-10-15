# frozen_string_literal: true
require 'rails_helper'

RSpec.describe 'Org::Sessions', type: :request do
  let(:organization) { create(:organization) }

  describe 'GET #new' do
    it 'renders the new template' do
      get org_login_path,
          headers: { 'HTTP_HOST' => 'org.localhost' }
      expect(response).to render_template('org/sessions/new')
    end
  end

  describe 'POST #create' do
    context 'with valid credentials' do
      before do
        post org_login_path(params: { session: { email: organization.email, password: organization.password } }),
             headers: { 'HTTP_HOST' => 'org.localhost' }
      end

      it 'sets the org id in session' do
        expect(session[:organization_id]).to eq(organization.id)
      end

      it 'redirects to the org page' do
        expect(response).to redirect_to(org_organization_path(organization))
      end
    end

    context 'with invalid credentials' do
      before do
        post org_login_path(params: { session: { email: organization.email, password: 'wrong_password' } }),
             headers: { 'HTTP_HOST' => 'org.localhost' }
      end

      it 'does not set the org id in session' do
        expect(session[:organization_id]).to be_nil
      end

      it 're-renders the new template' do
        expect(response).to render_template(:new)
      end
    end
  end

  describe 'DELETE #destroy' do
    before do
      login(organization)
      delete org_logout_path(organization),
             headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'resets the org id in session' do
      expect(session[:organization_id]).to be_nil
    end

    it 'redirects to the root path' do
      expect(response).to redirect_to(root_path)
    end
  end
end

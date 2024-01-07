# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Users', type: :request do
  let(:headers) { { 'HTTP_HOST' => 'localhost' } }

  describe 'GET /new' do
    before do
      get new_user_path, headers:
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the new template' do
      expect(response).to render_template(:new)
    end
  end

  describe 'POST /create' do
    context 'when valid params' do
      before do
        post users_path, params: { user: attributes_for(:user) }, headers:
      end

      it 'creates a new user' do
        expect(User.count).to eq(1)
      end
    end

    context 'when invalid params' do
      before do
        post users_path, params: { user: attributes_for(:user, :invalid_user) }, headers:
      end

      it 'does not create a new user' do
        expect(User.count).to eq(0)
      end
    end
  end

  describe 'GET /show' do
    let(:user) { create(:user) }

    before do
      get user_path(user), headers:
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the show template' do
      expect(response).to render_template(:show)
    end
  end

  describe 'GET /edit' do
    let(:user) { create(:user) }

    before do
      get edit_user_path(user), headers:
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders the edit template' do
      expect(response).to render_template(:edit)
    end
  end

  describe 'PUT /update' do
    let!(:user) { create(:user) }

    context 'when valid params' do
      before do
        put user_path(user), params: { user: attributes_for(:user, :update_user) }, headers:
      end

      it 'updates the user' do
        expect(user.reload.user_name).to eq('update_user_name')
      end
    end

    context 'when invalid params' do
      before do
        put user_path(user), params: { user: attributes_for(:user, :invalid_user) }, headers:
      end

      it 'does not update the user' do
        user_name = user.user_name
        expect(user.reload.user_name).to eq(user_name)
      end
    end

    context 'when add avatar' do
      before do
        put user_path(user), params: { user: attributes_for(:user, :update_user) }, headers:
      end

      it 'updates the user' do
        expect(user.reload.avatar).to be_attached
      end
    end
  end
end

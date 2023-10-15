# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'Org::Contacts', type: :request do
  let(:organization) { create(:organization) }
  before { login(organization) }

  describe 'GET #new' do
    before do
      get new_org_organization_contact_path(organization_id: organization.id),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders new view' do
      expect(response.body).to render_template(:new)
    end
  end

  describe 'POST #create' do
    context 'With valid attr' do
      it 'Creates a new contact' do
        expect do
          post org_organization_contacts_path(organization,
                                              params: { contact: attributes_for(:contact), format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }

        end.to change(Contact.all, :count).by(1)
      end
    end

    context 'With invalid attr' do
      it 'Does not create a new contact' do
        expect do
          post org_organization_contacts_path(organization,
                                              params: { contact: attributes_for(:contact, :invalid), format: :turbo_stream }),
               headers: { 'HTTP_HOST' => 'org.localhost' }

        end.not_to change(Contact.all, :count)
      end
    end
  end

  describe 'GET #edit' do
    let(:contact) { create(:contact, organization: organization) }

    before do
      get edit_org_contact_path(contact),
          headers: { 'HTTP_HOST' => 'org.localhost' }
    end

    it 'returns http success' do
      expect(response).to have_http_status(:success)
    end

    it 'renders edit contact form' do
      expect(response.body).to render_template(:edit)
    end
  end

  describe 'PUT #update' do
    let(:contact) { create(:contact, organization: organization, type: 'Phone') }

    context 'With valid attributes' do
      it 'Changes contact' do
        patch org_contact_path(contact,
                             params: { phone: { type: 'Phone', value: '987654321' }, format: :turbo_stream }),
            headers: { 'HTTP_HOST' => 'org.localhost' }
        contact.reload
        expect(contact.value).to eq('987654321')
      end
    end

    context 'With invalid attributes' do
      it 'Does not change contact' do
        old_value = contact.value
        patch org_contact_path(contact,
                               params: { phone: { type: 'Phone', value: '' }, format: :turbo_stream }),
              headers: { 'HTTP_HOST' => 'org.localhost' }
        contact.reload
        expect(contact.value).to eq(old_value)
      end
    end
  end

  describe 'DELETE #destroy' do
    let!(:contact) { create(:contact, organization: organization, type: 'Phone') }

    it 'Deletes a contact' do
      expect do
        delete org_contact_path(contact),
               headers: { 'HTTP_HOST' => 'org.localhost' }
      end.to change(Contact.all, :count).by(-1)
    end
  end
end

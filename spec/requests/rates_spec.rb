require 'rails_helper'

RSpec.describe "Rates", type: :request do
  let(:headers) { { 'HTTP_HOST' => 'localhost' } }
  let(:organization) { create(:organization) }
  let(:user) { create(:user) }

  before do
    login(user)
  end

  describe "GET #new" do
    it "returns http success" do
      get new_organization_rate_path(organization), headers: headers

      expect(response).to have_http_status(:success)
    end
  end

  describe "POST /create" do
    let(:organization) { create(:organization) }

    it "returns http success" do
      post organization_rates_path(organization), params: { rate: { value: 5 }, format: :turbo_stream }, headers: headers

      expect(response).to have_http_status(:success)
    end
  end
end

require 'rails_helper'

RSpec.describe "Searches", type: :request do
  let(:headers) { { 'HTTP_HOST' => 'localhost' } }
  let(:organizations) { create_list(:organization, 2) }

  before do
    meilisearch_service = double(MeilisearchService)
    allow(MeilisearchService).to receive(:new).and_return(meilisearch_service)
    allow(meilisearch_service).to receive(:search).and_return( organizations.map{ |e| e['id'] } )
  end

  describe "GET /index" do
    it "returns 200 status" do
      get(search_index_path, params: { q: '' }, headers:)
      expect(response).to have_http_status(200)
    end

    it "render index" do
      get(search_index_path, params: { q: '' }, headers:)
      expect(response).to render_template(:index)
    end
  end

end

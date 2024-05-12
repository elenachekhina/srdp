require 'rails_helper'

RSpec.describe MeilisearchService do
  let(:master_key) { Rails.application.credentials[Rails.env.to_sym][:meilisearch][:master_key] }
  let(:index_name) { 'test' }
  let(:client) { instance_double(MeiliSearch::Client) }
  let(:index) { instance_double(MeiliSearch::Index) }
  let(:object) { double('Object', id: 1, searchable_fields: { name: 'Test' }, class: double('Class', name: 'Test')) }

  before do
    allow(MeiliSearch::Client).to receive(:new).and_return(client)
    allow(client).to receive(:index).with(index_name.downcase).and_return(index)
  end

  let!(:service) { described_class.new }

  describe '#initialize' do
    it 'initializes MeiliSearch client with correct parameters' do
      expect(MeiliSearch::Client).to have_received(:new).with('http://localhost:7700', master_key)
    end
  end

  describe "#create" do
    before do
      allow(index).to receive(:add_documents)
      service.create(object)
    end

    it 'sends the correct data to MeiliSearch' do
      expect(index).to have_received(:add_documents).with(object.searchable_fields)
    end
  end

  describe '#update' do
    before do
      allow(index).to receive(:update_documents)
      service.update(object)
    end

    it 'sends the correct data to MeiliSearch for update' do
      expect(index).to have_received(:update_documents).with(object.searchable_fields)
    end
  end

  describe '#search' do
    let(:query) { 'query' }
    let(:search_result) { { 'hits' => [{ 'id' => 1 }] } }

    before do
      allow(index).to receive(:search).with(query).and_return(search_result)
    end

    it 'returns the correct search results' do
      expect(service.search(index_name, query)).to eq([1])
    end
  end

  describe '#destroy' do
    before do
      allow(index).to receive(:delete_document)
      service.destroy(object)
    end

    it 'sends a request to delete the document' do
      expect(index).to have_received(:delete_document).with(object.id)
    end
  end
end
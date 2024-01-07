RSpec.shared_context "mocked MeilisearchService", shared_context: :metadata do
  before do
    meilisearch_service = double(MeilisearchService)

    allow(MeilisearchService).to receive(:new).and_return(meilisearch_service)
    allow(meilisearch_service).to receive(:create)
    allow(meilisearch_service).to receive(:update)
    allow(meilisearch_service).to receive(:destroy)
  end
end

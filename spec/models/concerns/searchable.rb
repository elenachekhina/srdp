shared_examples_for 'Searchable' do
  let(:meilisearch_service) { double(MeilisearchService) }
  let(:object) { create(klass.name.downcase.to_sym) }

  before do
    allow(MeilisearchService).to receive(:new).and_return(meilisearch_service)
    allow(meilisearch_service).to receive(:create)
    allow(meilisearch_service).to receive(:update)
    allow(meilisearch_service).to receive(:destroy)
  end

  it 'call create after save' do
    object.save

    expect(meilisearch_service).to have_received(:create)
  end

  it 'call update after update' do
    object.update(name: 'New name')

    expect(meilisearch_service).to have_received(:update)
  end

  it 'call destroy after destroy' do
    object.destroy

    expect(meilisearch_service).to have_received(:destroy)
  end
end
shared_examples_for 'Searchable' do
  let(:meilisearch_service) { double(MeilisearchService) }

  before do
    object.class
    allow(MeilisearchService).to receive(:new).and_return(meilisearch_service)
    allow(meilisearch_service).to receive(:create).with(instance_of(object.class))
    allow(meilisearch_service).to receive(:update).with(instance_of(object.class))
    allow(meilisearch_service).to receive(:destroy).with(instance_of(object.class))
  end

  it 'call create after save' do
    object.save

    expect(meilisearch_service).to have_received(:create).with(object)
  end

  it 'call update after update' do
    object.update(update_dict)

    expect(meilisearch_service).to have_received(:update).with(object)
  end

  it 'call destroy after destroy' do
    object.destroy

    expect(meilisearch_service).to have_received(:destroy).with(object)
  end
end
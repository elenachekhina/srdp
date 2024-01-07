class MeilisearchService
  def initialize
    master_key = Rails.application.credentials[Rails.env.to_sym][:meilisearch][:master_key]
    @client = MeiliSearch::Client.new('http://localhost:7700', master_key)
  end

  def create(object)
    @client.index(index_name(object)).add_documents(object.searchable_fields)
  end

  def update(object)
    @client.index(index_name(object)).update_documents(object.searchable_fields)
  end

  def search(index, q)
    @client.index(index).search(q)['hits'].map{ |e| e['id'] }
  end

  def destroy(object)
    @client.index(index_name(object)).delete_document(object.id)
  end

  private

  def index_name(object)
    object.class.name.downcase
  end
end
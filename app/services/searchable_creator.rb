class SearchableCreator
  def initialize(klass, params)
    @klass = klass
    @params = params
  end

  def call
    obj = @klass.new(@params)
    if obj.save
      create_meilisearch_document(obj)
    end
    obj
  end

  private

  def create_meilisearch_document(obj)
    MeilisearchService.new.create(obj)
  end
end

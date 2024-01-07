class SearchableCreator
  def initialize(klass, params)
    @klass = klass
    @params = params
  end

  def call
    obj = @klass.new(@params)
    if obj.save
      perform_post_create_actions(obj)
    end
    obj
  end

  private

  def perform_post_create_actions(obj)
    MeilisearchService.new.create(obj)
  end
end

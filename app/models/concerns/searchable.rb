module Searchable
  extend ActiveSupport::Concern

  included do
    after_update { MeilisearchService.new.update(self) }
    after_destroy { MeilisearchService.new.destroy(self) }
  end

  def searchable_fields
    self.slice(:id, :name, :description)
  end
end

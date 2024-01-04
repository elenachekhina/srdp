module Searchable
  extend ActiveSupport::Concern

  included do
    unless Rails.env.test?
      after_create { MeilisearchService.new.create(self) }
      after_update { MeilisearchService.new.update(self) }
      after_destroy { MeilisearchService.new.destroy(self) }
    end
  end

  def searchable_fields
    self.slice(:id, :name, :description)
  end
end

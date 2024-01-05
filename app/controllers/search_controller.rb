class SearchController < ApplicationController

  def index
    q = params[:q]
    @organizations = Organization.find(MeilisearchService.new.search('organization', q))
  end
end

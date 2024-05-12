class SearchController < ApplicationController

  def index
    q = params[:q]

    meilisearch_service = MeilisearchService.new

    services_org_id = Array(Service.where(id: meilisearch_service.search('service', q))).map(&:organization_id)
    addresses_org_id = Array(Address.where(id: meilisearch_service.search('address', q))).map(&:organization_id)
    org_id = Array(meilisearch_service.search('organization', q))

    @organizations = Organization.where(id: services_org_id.union(addresses_org_id).union(org_id))
  end
end

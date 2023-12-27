# frozen_string_literal: true

module ApplicationHelper
  def main_domain
    !(request.subdomain.present? && request.subdomain != 'www')
  end

  def google_maps_api_key
    Rails.application.credentials[Rails.env.to_sym][:google][:map]
  end
end

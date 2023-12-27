# frozen_string_literal: true

module ApplicationHelper
  def main_domain
    !(request.subdomain.present? && request.subdomain != 'www')
  end
end

module ApplicationHelper
  def main_domain
    !(request.subdomain.present? && request.subdomain != 'www')
  end
end

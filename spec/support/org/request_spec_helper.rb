# frozen_string_literal: true

module RequestSpecHelper
  def login(organization)
    post org_login_path, params: { session: { email: organization.email, password: organization.password } },
                         headers: { 'HTTP_HOST' => 'org.localhost' }
  end
end

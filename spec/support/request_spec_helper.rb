# frozen_string_literal: true

module RequestSpecHelper
  def login(user)
    post login_path, params: { session: { email: user.email, password: user.password } },
                     headers: { 'HTTP_HOST' => 'localhost' }
  end
end

module Authentication
  def http_basic_auth_header(user)
    {
      'HTTP_AUTHORIZATION' => ActionController::HttpAuthentication::Basic.encode_credentials(
        user.email,
        user.password
      )
    }
  end
end

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins 'http://localhost:8080', 'http://127.0.0.1:8080', 'localhost:8080', '127.0.0.1:8080', 'localhost', '127.0.0.1'
    resource '*',
      headers: :any,
      methods: [:get, :post, :put, :delete, :options],
      credentials: true
  end
end
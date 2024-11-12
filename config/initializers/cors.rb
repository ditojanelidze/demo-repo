Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '10.0.2.2:3000', /[a-z0-9\-]+\.ngrok-free\.app/ # Replace with appropriate domain or IP

    resource '*',
             headers: :any,
             methods: [:get, :post, :patch, :put, :delete, :options, :head],
             credentials: true
  end
end
Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allowed_origins = ENV['CORS_ALLOWED_ORIGINS'].split(',')

  allow do
    origins allowed_origins

    resource '*',
             headers: :any,
             methods: %i[get post put patch delete options head],
             credentials: true
  end
end

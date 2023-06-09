Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    if Rails.env.development? || Rails.env.test?
      origins 'http://localhost:8080'
    else
      origins ENV['ORIGIN'] # Replace with the actual origin(s) of your Vue frontend in production
    end

    # Specify the resources you want to allow cross-origin requests for
    resource '/api/*',
      headers: :any,
      methods: [:get, :post, :put, :patch, :delete, :options, :head],
      credentials: true

    # Optionally, you can allow cross-origin requests for specific routes
    #resource '/authenticity_token',
    #  headers: :any,
    #  methods: [:get],
    #  credentials: true
  end
end

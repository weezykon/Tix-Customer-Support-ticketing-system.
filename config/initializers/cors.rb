# Be sure to restart your server when you modify this file.

# Avoid CORS issues when API is called from the frontend app.
# Handle Cross-Origin Resource Sharing (CORS) in order to accept API requests from frontend apps.

# Read more: https://github.com/cyu/rack-cors

Rails.application.config.middleware.insert_before 0, Rack::Cors do
  allow do
    origins '*' # In production, you should restrict this to your frontend's domain
    resource '/graphql',
      headers: :any,
      methods: [:get, :post, :options]
  end
end

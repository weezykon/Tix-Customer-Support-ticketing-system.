# frozen_string_literal: true

Rails.application.routes.draw do
  post 'authenticate', to: 'authentication#authenticate'
  post 'register', to: 'registration#create'

  mount GraphiQL::Rails::Engine, at: '/graphiql', graphql_path: '/graphql' if Rails.env.development?
  post '/graphql', to: 'graphql#execute'
end

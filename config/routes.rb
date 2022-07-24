Rails.application.routes.draw do
  namespace :admin do
      resources :users
      resources :scripts

      root to: "users#index"
    end
  post "/graphql", to: "graphql#execute"
  devise_for :users, controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  root to: "home#index"
end

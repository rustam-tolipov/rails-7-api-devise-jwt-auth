Rails.application.routes.draw do

  mount Rswag::Ui::Engine => '/'
  mount Rswag::Api::Engine => '/api-docs'
  
  namespace :api do
    namespace :v1 do

      get '/search', to: 'users#search'
      
      resources :users 
    end
  end
  
  get 'users/index'
  scope :api do
    scope :v1 do
      devise_for :users,
                 path: 'auth',
                 path_names: {
                   sign_in: 'login',
                   sign_out: 'logout',
                   registration: 'signup'
                 },
                 controllers: {
                   registrations: 'api/v1/registrations',
                   sessions: 'api/v1/sessions',
                 }, defaults: { format: :json }
      devise_scope :user do
        get '/auth/me', to: 'api/v1/users#me', as: :user_root
        get '/auth/users', to: 'api/v1/users#index', as: :users
        get '/auth/users/:id', to: 'api/v1/users#show', as: :user
        get '/users/show/:username', to: 'api/v1/users#show_by_username', as: :show_by_username
        put '/auth/users/:id', to: 'api/v1/users#update', as: :update_user
        delete '/auth/users', to: 'api/v1/users#destroy', as: :destroy_user
        post 'password/forgot', to: 'api/v1/password#forgot'
        post 'password/reset', to: 'api/v1/password#reset'
      end
    end
  end
end

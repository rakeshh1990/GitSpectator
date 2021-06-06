Rails.application.routes.draw do
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
  root 'users#index'

  get '/authorize', to: 'login#github_authorize'
  get '/github/callback', to: 'login#github_callback'
  post '/logout', to: 'login#logout'

  resources :users, only: %i[index] do
    resources :repositories, only: %i[index show]
    resources :projects, only: %i[index show]
  end
end

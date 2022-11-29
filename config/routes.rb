Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html
  get "search", to: "pages#search"
  get "result", to: "pages#result"

  #Routes-test pour l'API :
  get '/oauth/callback', to: 'data#create_session'
  get '/index', to: 'data#index'
  root to: 'data#index'
end

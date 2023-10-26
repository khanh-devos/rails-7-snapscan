Rails.application.routes.draw do
  devise_for :users
  get '/users/sign_out', to: "users#user_sign_out", as: 'user_sign_out'


  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  
  resources :users, only: %i[show] do
    resources :groups, only: %i[index show new create] do
      resources :expenses, only: %i[show new create]
    end
  end
  
  get '/home', to: "groups#index", as: 'home'

  root "users#splash"
end

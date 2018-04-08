Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :login, only: [:create]

      resources :users, only: [:index, :create, :show, :update, :destroy]

      resources :customers, only: [:index, :create]
    end
  end


end

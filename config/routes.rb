Rails.application.routes.draw do

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    namespace :v1 do
      resources :login, only: [:create]
      resources :users, only: [:index, :create, :show, :update, :destroy]
      resources :customers, only: [:index, :create, :update, :destroy]

      resources :product_types, only: [:index, :create, :update, :destroy]
      resources :component_types, only: [:index, :create, :update, :destroy]

      resources :products, only: [:index, :create, :update, :destroy]
      resources :components, only: [:index, :create, :update, :destroy]
      resources :production_plans, only: [:index, :create, :update, :destroy]
    end
  end


end

Rails.application.routes.draw do
  
  devise_for :users
  resources :users
  resources :advertisements do
    collection do
      get :admin_index
    end
    member do
      patch :set_type
    end
  end

  root "advertisements#index"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end

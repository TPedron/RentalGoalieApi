Rails.application.routes.draw do
  
  post   '/login',   to: 'sessions#create'
  delete '/logout',  to: 'sessions#destroy'
  
  #resources :users do
  resources :goalies do
    member do
      get :games
    end
  end
  
  resources :clients do
    member do
      get :games
    end
  end
  
  resources :games do
    member do
      post :accept
      post :unaccept
      post :rate
    end
  end
  
end

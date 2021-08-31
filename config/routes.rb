Rails.application.routes.draw do
  root 'pages#home'
  resource :pages, only: [] do
    collection do
      get :home
    end
  end
  resources :hotels, only: :index do
    collection do
      get :search_form
      post :search
    end
  end
  resources :reservations, only: %i[new create show]
end

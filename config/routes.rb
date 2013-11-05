Myvdegree::Application.routes.draw do

  resources :dashboard
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}, controllers: {omniauth_callbacks: 'omniauth_callbacks' }

  authenticated do
    root to: 'dashboard#index', as: :authenticated_root, via: [:get, :post]
  end

  root to: "home#index"
end

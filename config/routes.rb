Myvdegree::Application.routes.draw do
  devise_for :users, path_names: {sign_in: 'login', sign_out: 'logout'}

  authenticated do
    root to: 'dashboard#index', as: :authenticated_root
  end

  root to: "home#index"
end

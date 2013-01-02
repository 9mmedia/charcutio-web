CharcutioWeb::Application.routes.draw do
  devise_for :users
  root :to => 'pages#home'
  resources :boxes do
    member do
      post :photo
      post :report
      get :set_points
      match 'data/:type' => "boxes#data" # /boxes/:id/data/:type
    end
  end
  resources :teams
  resources :meats
  resources :recipes
  match 'recipes/:id/fork' => 'recipes#fork', as: :fork_recipe
  resources :users, only: :show
end

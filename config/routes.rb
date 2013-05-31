Magi::Application.routes.draw do
  resources :jobs, only: [:index, :show, :create, :update, :destroy] do
    resources :builds, only: [:index, :show, :create]
  end
end

Magi::Application.routes.draw do
  root to: "jobs#index"

  resources :jobs do
    resources :builds, only: [:index, :show, :create, :update, :destroy]
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do

      resources :stakeholders, only: [:index, :show, :create, :update, :destroy]

      resources :agendas, only: [:index, :show, :create, :update, :destroy]

    end
  end
end

Rails.application.routes.draw do
  namespace :api do
    namespace :v1 do
      
      resources :news_sources, only: [:index, :show, :create, :update, :destroy]

      resources :stakeholders, only: [:index, :show, :create, :update, :destroy]

      resources :agendas, only: [:index, :show, :create, :update, :destroy]

      get "trending_topics", to: "trending_topics#index"
    end
  end
end

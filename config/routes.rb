Rails.application.routes.draw do
  devise_for :users
  root to: "items#index"

  # 商品に関するルート（index, new, create）をまとめて定義します
  resources :items, only: [:index, :new, :create, :show, :edit,:update]

  get "up" => "rails/health#show", as: :rails_health_check
end

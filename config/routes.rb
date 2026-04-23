# Railsアプリ全体の「道しるべ（ルーティング）」を定義する枠組みの開始ですhttps://guides.rubyonrails.org/routing.html
Rails.application.routes.draw do
  # devise（ユーザー管理機能）に必要なURLをまとめて自動作成します
  devise_for :users
  # アプリのトップページ（localhost:3000）を開いたとき、itemsコントローラーのindexアクションを動かします
  root to: "items#index"

  # アプリが正常に動いているかチェックするための専用URL（/up）の設定です
  # サーバーが生きているときに200（正常）という応答を返します
  get "up" => "rails/health#show", as: :rails_health_check

end

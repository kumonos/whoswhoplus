require 'resque/server'
SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'

  # サインイン時のコールバック画面
  get '/auth/facebook/callback' => 'home#callback'

  # サインアウト
  get '/sign_out' => 'home#sign_out'

  # 紹介画面
  get '/relations/:user' => 'relations#index', as: :relations

  # メッセージ送信画面
  resources :messages, only: [:index, :new, :create]

  # 友人の友人一覧表示画面
  get '/friends/:user_fb_id/:fb_id' => 'friends#show', as: :friends

  # 開発環境のみのダミーログイン画面
  if Rails.env.development?
    get '/dummy_login' => 'home#dummy_form'
    post '/dummy_login' => 'home#dummy_login'
  end

  match '*path' => 'application#render_404', via: :all

  mount Resque::Server.new, at: "/resque"
end

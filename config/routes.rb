SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'

  # サインイン時のコールバック画面
  get '/home/callback' => 'home#callback'

  # サインアウト
  get '/sign_out' => 'home#sign_out'

  # 友人の友人一覧表示画面
  get '/friends/:fb_id' => 'friends#show', as: :friends

  # 紹介画面
  get '/relations/:user' => 'relations#index', as: :relations

  # メッセージ送信画面
  get '/relations/:user/via/:via' => 'relations#show', as: :relation

  #profilesの扱いがよく解んなくなった時の残骸（削除してもOKかも）
  resources :profiles do
	collection { get "search" }
  end

  # 開発環境のみのダミーログイン画面
  if Rails.env.development?
    get '/dummy_login' => 'home#dummy_form'
    post '/dummy_login' => 'home#dummy_login'
  end
end

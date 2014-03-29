SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'
  get '/home/callback' => 'home#callback'

  # 紹介画面
  get '/relations/:user' => 'relations#index', as: :relations

  # メッセージ送信画面
  get '/relations/:user/via/:via' => 'relations#show', as: :relation
  get 'home/callback' => 'home#callback'

  # 友人の友人一覧表示画面
  get '/friends/:user_fb_id/:fb_id' => 'friends#show', as: :friends

  #profilesの扱いがよく解んなくなった時の残骸（削除してもOKかも）
  resources :profiles do
	collection {get "search"}
  end

end




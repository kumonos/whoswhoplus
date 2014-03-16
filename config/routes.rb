SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'
  get '/home/callback' => 'home#callback'

  # 紹介画面
  get '/relations/:user' => 'relations#index'

  # メッセージ送信画面
  get '/relations/:user/via/:via' => 'relations#show'
end

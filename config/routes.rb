SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'
  get 'home/callback' => 'home#callback'
end

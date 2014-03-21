SampleKoalaRailsApp::Application.routes.draw do
  root :to => 'home#index'
  get 'home/callback' => 'home#callback'

  resources :profiles do
	collection {get "search"}
  end

end




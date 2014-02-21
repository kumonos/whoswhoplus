SampleKoalaRailsApp::Application.routes.draw do
  # The priority is based upon order of creation:
  # first created -> highest priority.



  root :to => 'home#index'

  get 'home/callback' => 'home#callback'

end

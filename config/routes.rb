Spree::Core::Engine.add_routes do
  namespace :admin do
    resources :orders do
      member do
        post :sync_kashflow
      end
    end
  end
end

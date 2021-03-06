Rails.application.routes.draw do


  get 'errors/not_found'

  get 'errors/internal_server_error'

  get 'how_it_works' => 'how_it_works#index'

  get 'confirm' => 'confirm#index'
  match 'confirm/paydunya' => 'confirm#paydunya', via: [:get, :post]
  get 'comments/refresh' => 'comments#refresh'
  get '/undefined' => 'home#index'
  mount RailsAdmin::Engine => '/admin', as: 'rails_admin'

  devise_for :users do
    resources :orders
    resources :robots
  end

  resources :submissions do
  end

  resources :comments do
  end

  resources :products do
  end
  resources :orders do
  end
  match "/auctions/ended" => "auctions#ended", :via => :post
  resources :auctions do
    resources :bids , only: [ :create] do
    end
    resources :robots  do
    end
  end

  get '404' => 'errors#not_found'
  get '500' => 'errors#internal_server_error'
  get 'closed' =>'auctions#closed'
  get 'online' =>'auctions#online'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'home#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end

  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end

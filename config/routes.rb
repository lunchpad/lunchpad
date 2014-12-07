Rails.application.routes.draw do

  devise_for :users, :controllers => { registrations: 'registrations' }

  resources :accounts, only: [:new, :create, :show, :edit, :update, :destroy] do
    put :payment, on: :member
    post :calendar, on: :member
    resources :available_menu_items, only: :index do
      get :query, on: :collection
    end
    resources :orders, only: [:index, :new, :create, :show, :edit, :update, :destroy]
    resources :ordered_items, except: [:edit, :show]
  end

  resources :available_menu_items, only: :destroy

  resources :account_ownerships, only: [:index, :create, :destroy, :new]

  resources :vendors, shallow: true do
    resources :menu_items, except: [:index]
  end

  resources :admins, only: :index

  resources :schools do
    get :order, on: :member
    get :accounts, on: :member
    get :admins, on: :member
    put :make_admin, on: :member
    put :remove_admin, on: :member
    resources :off_days
  end

  get '/sign_in' => 'welcome#sign_in'

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
  root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

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

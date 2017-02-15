Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  resource :cart

  resources :products do
    member do
      post :add_to_cart
    end
  end

  # scope :module => "admin", :as => "admin", :path => "admin" do
  namespace :admin do
    resources :products
  end

  root "products#index"

end

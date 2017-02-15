Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  # scope :module => "admin", :as => "admin", :path => "admin" do
  namespace :admin do
    resources :products
  end

  root "welcome#index"

end

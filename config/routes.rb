Addoner::Application.routes.draw do

  authenticated :user do
    root :to => 'home#index'
  end
  root :to => "home#index"
  devise_for :users
  resources :users
  resources :addoners do
    collection do
      get :create_extension
      get :download_sample_extension
      get :generate_extension
    end
  end

end
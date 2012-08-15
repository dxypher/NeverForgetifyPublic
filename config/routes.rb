NeverForgetify::Application.routes.draw do

  get "twilio/create"
  get "/api_test" => "users#facebook_api_test"
  

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout' }, :controllers => { :omniauth_callbacks => "users/omniauth_callbacks" }
  devise_scope :user do

    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    
  end
  
  root to: "notifications#index"
  
  resources :notifications do
    resources :schedules
    collection do 
      get :ajax_test
    end
  end
  
  
  match "/twilio" => 'twilio#create'
  match "/users/:id/reset_form" => 'users#reset_password_form', as: 'reset_password_form'
  match "/users/:id/reset" => 'users#reset_password', as: 'reset_password'
  
  
  resources :users
  
  namespace :api do
    resources :notifications
  end

  namespace :v2 do
    resources :notifications
  end
end

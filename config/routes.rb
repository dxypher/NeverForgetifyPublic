NeverForgetify::Application.routes.draw do

  get "twilio/create"

  devise_for :users, :path_names => { :sign_in => 'login', :sign_out => 'logout'}
  devise_scope :user do
    get "/login" => "devise/sessions#new"
    get "/logout" => "devise/sessions#destroy"
    
  end
  
  root to: "notifications#index"
  
  resources :notifications do
    resources :schedules
  end
  
  
  match "/twilio" => 'twilio#create'
  
  

end

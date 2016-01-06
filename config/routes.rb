Prelaunchr::Application.routes.draw do

  ActiveAdmin.routes(self)

  devise_for :admin_users, ActiveAdmin::Devise.config

  root :to => "users#new"

  match 'users/create' => 'users#create'

  match 'refer-a-friend' => 'users#refer'

  match 'privacy-policy' => 'users#policy'

  post 'webhook', to: 'users#webhook'

  unless Rails.application.config.consider_all_requests_local
    match '*not_found', to: 'users#redirect', :format => false
  end
  
end

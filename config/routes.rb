Rails.application.routes.draw do
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'visitor#home'
    get '/aqm' => 'visitor#aqm'
end

Rails.application.routes.draw do
  resources :commentaries
  # devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'visitor#index'
    get '/aqm' => 'visitor#aqm'

	resources :genres, only: [:new, :create, :edit, :update]
	resources :poems, only: [:new, :create, :edit, :update, :destroy]

	resources :users, only: [:edit, :update, :show, :index] do
		resources :poems, only: [:show, :index] do 
			resources :commentaries, only: [:index, :new, :create]
		end
		resources :fan_idols, only: [:create]
		resources :rival_victims, only: [:create]
	end

	resources :commentaries, only: [:edit, :update, :destroy]
	resources :fan_idols, only: [:destroy]
	resources :rival_victims, only: [:destroy]

end

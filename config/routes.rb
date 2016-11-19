Rails.application.routes.draw do
	# devise_for :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'visitor#index'
    get '/aqm' => 'visitor#aqm'

	resources :genres, only: [:new, :create, :edit, :update]
	resources :commentaries, only: [:edit, :update, :destroy]
	resources :poems, only: [:new, :create, :edit, :update, :destroy] do 
		resources :voters, only: [:create, :destroy]
		resources :commentaries, only: [:index, :new, :create]
	end

	resources :users, only: [:edit, :update, :show, :index] do
		resources :poems, only: [:show, :index]
	end

	resources :idols, only: [] do
		resources :fans, only: [:create, :destroy]
	end

	resources :victims, only: [] do
		resources :rivals, only: [:create, :destroy]
	end

	resources :commentaries, only: [:edit, :update, :destroy]

end

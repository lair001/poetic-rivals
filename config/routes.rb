Rails.application.routes.draw do
	# devise_for :users
	# For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

	devise_for :users, controllers: { sessions: 'users/sessions', passwords: 'users/passwords', registrations: 'users/registrations', omniauth_callbacks: 'users/omniauth_callbacks' }

    root 'visitor#index'
    get '/aqm' => 'visitor#aqm'

	resources :commentaries, only: [:edit, :update, :destroy]
	resources :poems, only: [] do 
		resources :voters, only: [:create, :destroy], param: :voter_id
	end

	resources :users, only: [:index, :show] do
		resources :poems do
			resources :commentaries, only: [:index, :new, :create, :edit, :update, :destroy]
		end
	end

	resources :idols, only: [] do
		resources :fans, only: [:create, :destroy], param: :fan_id
	end

	resources :victims, only: [] do
		resources :rivals, only: [:create, :destroy], param: :rival_id
	end

	scope '/admin' do
    	resources :users, only: [:edit, :update], as: :admin_users, controller: :'admin/users'
		resources :genres, only: [:new, :create, :edit, :update], as: :admin_genres, controller: :'admin/genres'
	end

	scope '/leaderboard' do
		resources :users, only: [:index], as: :leaderboard_users, controller: :'leaderboard/users'
	end

	scope '/mod' do
		resources :users, only: [:update], as: :mod_users, controller: :'mod/users'
	end

end

Rails.application.routes.draw do

  devise_for :trafficpolices
  devise_for :admins
  devise_for :citizens
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
  	namespace :v1, defaults: {format: :json} do
  		  	namespace :admin, defaults: {format: :json} do
  		  		resources :sessions, only: [:create,:destroy]
  		  		resources :registrations, only: [:create,:destroy]
  		  	end
		  	namespace :citizen, defaults: {format: :json} do
		  		resources :sessions, only: [:create,:destroy]
		  		resources :registrations, only: [:create,:destroy]
		  	end
		  	namespace :trafficpolice, defaults: {format: :json} do
		  		resources :sessions, only: [:create,:destroy]
		  		resources :registrations, only: [:create,:destroy]
		  	end
  		# resources :sessions, only: [:create,:destroy]
  		# resources :admin_registrations, only: [:create]
  		# resources :citizens_sessions, only: [:create,:destroy]
  		# resources :citizens_registrations, only: [:create]
  		# resources :commercial_sessions, only: [:create,:destroy]
  		# resources :commercial_registrations, only: [:create]
  		# resources :challans
  	end
  end

end

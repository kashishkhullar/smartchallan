Rails.application.routes.draw do

  devise_for :commercials
  devise_for :trafficpolices
  devise_for :admins
  devise_for :citizens
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api, defaults: {format: :json} do
  	namespace :v1, defaults: {format: :json} do
  		  	namespace :admin, defaults: {format: :json} do
  		  		resources :sessions, only: [:create,:destroy]
  		  		resources :registrations, only: [:create,:destroy]
  		  		post 'registrations/new_traffic_police' => 'registrations#create_traffic_police'
            post 'registrations/new_admin' => 'registrations#create_admin'
  		  	end
		  	namespace :citizen, defaults: {format: :json} do
		  		resources :sessions, only: [:create,:destroy]
		  		resources :registrations, only: [:create,:destroy]
		  	end
		  	namespace :trafficpolice, defaults: {format: :json} do
		  		resources :sessions, only: [:create,:destroy]
		  		resources :registrations, only: [:create,:destroy]
		  	end
		  	namespace :commercial, defaults: {format: :json} do
		  		resources :sessions, only: [:create,:destroy]
		  		resources :registrations, only: [:create,:destroy]
		  		resources :drivers, only: [:create,:destroy,:update]
          post'drivers/all' =>'drivers#index'
           post'drivers/show' =>'drivers#show'
		  		post 'vehicles/register' =>'vehicles#create'
		  		post 'vehicles/unregister'=>'vehicles#destroy'
		  	end

  		# resources :sessions, only: [:create,:destroy]
  		# resources :admin_registrations, only: [:create]
  		# resources :citizens_sessions, only: [:create,:destroy]
  		# resources :citizens_registrations, only: [:create]
  		# resources :commercial_sessions, only: [:create,:destroy]
  		# resources :commercial_registrations, only: [:create]
  		  resources :challans, only: [:create,:destroy,:update]
  		  post 'challan/all' => 'challans#index'
  		  post 'challan/show'=> 'challans#show'
  		  post 'challan/create'=>'challans#create'
  		  post 'challan/show/date' => 'challans#show_dated'
  	end
  end
end

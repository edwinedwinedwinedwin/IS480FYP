Rails.application.routes.draw do
  root 'pages#home' # root page
  resources :sessions, only: [:new, :create, :destroy] # only allow new,create,destroy action for sessions
  resources :users   
  get 'signup' => 'users#new' # display create user page
  post'users' => 'users#create' # process creation of user
  get 'pages/comrules' => 'pages#comrules' # display com rules
  get 'pages/term' => 'pages#term' # display terms
  get 'login' => 'sessions#new' # show login form
  post 'sessions/create' => 'sessions#create' # process login
  get 'sessions/destroy' => 'sessions#destroy' # log out and invalidate session
  get 'dashboard/index' => 'dashboards#index' # Display page upon successful login
  get 'admins/index' => 'admins#index'
  get 'users/changepass/:id' => 'users#changepass'
  get 'admins/index' => "admins#index"
  match '/:controller/:action/(:id)', via: [:get, :post] # last route
end

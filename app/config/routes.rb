Rails.application.routes.draw do  
  root 'pages#home' # root page

  # project reward backers routes
  get 'project_reward_backers/index' => 'project_reward_backers#index'
  get 'project_reward_backers/new' => 'project_reward_backers#new'
  get 'project_reward_backers/edit' => 'project_reward_backers#edit'
  post 'project_reward_backers' => 'project_reward_backers#create'
  post 'project_reward_backers/destroy/(:id)' => 'project_reward_backers#destroy'

  # project members routes  
  get 'project_members/index' => 'project_members#index'
  get 'project_members/new' => 'project_members#new'
  get 'project_members/edit/:id' => 'project_members#edit'  
  post 'project_members' => 'project_members#create'  
  #get 'project_members/edit' => => 'project_members#index'
  post 'project_members/destroy/(:id)' => 'project_members#destroy' 

	
  get 'project_milestones/new' => 'project_milestones#new'
  get 'project_milestones/index' => 'project_milestones#index'
  post 'project_milestones' => 'project_milestones#create'
  get 'project_milestones/edit' => 'project_milestones#edit'    
  post 'project_milestones/destroy/(:id)' => 'project_milestones#destroy' 

  # user shipping addresses routes
  get 'user_shipping_addresses/index' => 'user_shipping_addresses#index'
  get 'user_shipping_addresses/edit' => 'user_shipping_addresses#edit'
  get 'user_shipping_addresses/new' => 'user_shipping_addresses#new'
  post 'user_shipping_addresses' => 'user_shipping_addresses#create'
  post 'user_shipping_addresses/destroy/(:id)' => 'user_shipping_addresses#destroy'

  # project rewards routes
  get 'project_rewards/index' => 'project_rewards#index'
  get 'project_rewards/edit' => 'project_rewards#edit'
  get 'project_rewards/new' => 'project_rewards#new'
  post 'project_rewards' => 'project_rewards#create'
  post 'project_rewards/destroy/(:id)' => 'project_rewards#destroy'

  #get 'projects/new' => 'projects/new'
  get 'project_inspirations/new' => 'project_inspirations#new'
  get 'project_inspirations/index' => 'project_inspirations#index'
  get 'project_inspirations/edit' => 'project_inspirations#edit'
  post 'project_inspirations' => 'project_inspirations#create'
  post 'project_inspirations/destroy/(:id)' => 'project_inspirations#destroy'

  resources :project_reward_backers
  resources :sessions, only: [:new, :create, :destroy] # only allow new,create,destroy action for sessions
  resources :users   
  resources :user_expertises
  resources :project_members
  resources	:project_milestones
  resources :project_rewards
  resources :project_updates
  resources :project_inspirations
  resources :projects
  resources :project_proposals


  get 'signup' => 'users#new' # display create user page
  post'users' => 'users#create' # process creation of user  
  get 'pages/comrules' => 'pages#comrules' # display com rules
  get 'pages/term' => 'pages#term' # display terms
  get 'login' => 'sessions#new'# show login form  
  get 'editprofile' => 'users#edit#:id'
  get 'manageaddress' => 'user_shipping_addresses#index#:user_id' # edit user shipping address
  get 'newaddress' => 'user_shipping_addresses#new' # new user shipping address
  get 'admins/editprofile' => 'users#edit#:id'
  post 'sessions/create' => 'sessions#create' # process login
  get 'sessions/destroy' => 'sessions#destroy' # log out and invalidate session
  get 'dashboard/index' => 'dashboards#index' # Display page upon successful login

  post 'users/updateProfilePic/(:id)' => 'users#updateProfilePic', as: :updateProfilePic
  get 'admins/index' => 'admins#index'
  get 'changepass' => 'users#changepass#:id'
  get 'admins/changepass' => 'users#changepass#:id'
  get 'admins/index' => "admins#index"
  post 'sessions/resetpass' => 'users#resetpass'

  get 'GetStarted' => 'project_proposals#new' # display create proposal page
  post 'project_proposals' => 'project_proposals#create' # process creation of proposal
  post 'project_proposals/accept/(:id)' => 'project_proposals#accept', as: :approveProposal
  post 'project_proposals/reject/(:id)' => 'project_proposals#reject', as: :rejectProposal
  get 'project_proposals/success' => 'project_proposals#success' #success page after getstarted
  post 'project_proposals/manage' => 'project_proposals#manage', as: :checkProposalStatus # display create proposal page


  post 'projects/manage' => 'projects#manage', as: :manageProjectStatus # display create proposal page
  post 'projects/updateCategory/(:id)' => 'projects#updateCategory', as: :updateCategory
  get 'projects/show/:id' => 'projects#show', as: :showProject

  # user expertises routes
  get 'user_expertises/index' => 'user_expertises#index'
  get 'user_expertises/new' => 'user_expertises#new', as: :newExpertise
  post 'user_expertises' => 'user_expertises#create'

  match '/:controller/:action/(:id)', via: [:get, :post] # last route

end

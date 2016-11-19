Rails.application.routes.draw do  
  root 'pages#home' # root page

  resources :project_reward_backers
  resources :sessions, only: [:new, :create, :destroy] # only allow new,create,destroy action for sessions
  resources :users   
  resources :user_expertises
  resources :project_members
  resources :project_milestones
  resources :project_rewards
  resources :project_updates
  resources :project_inspirations
  resources :projects
  resources :project_proposals
  resources :project_proposal_imgs
  resources :payments

  #Other Routes
  get 'pages/comrules' => 'pages#comrules', as: :communityRule # display com rules
  get 'pages/term' => 'pages#term', as: :termNCondition # display terms

  #Normal User
  get 'signup' => 'users#new', as: :signup #display create user page
  post 'signup' => 'users#create', as: :createUser # process creation of user
  get 'login' => 'sessions#new' , as: :login # show login form
  post 'login' => 'sessions#create', as: :loginProcess # process login

  get 'logout' => 'sessions#destroy', as: :logout # log out and invalidate session
  get 'editprofile' => 'users#edit#:id', as: :editUserProfile
  get 'dashboard/index' => 'dashboards#index', as: :dashboardIndex # Display page upon successful login
  post 'users/updateProfilePic/(:id)' => 'users#updateProfilePic', as: :updateProfilePic
  get 'changepassword' => 'users#changepass', as: :userChangePasswordPage
  post 'changepassword' => 'users#changepassProcess', as: :userChangePassword
  get 'resetpassword' => 'sessions#resetpass', as: :userResetPasswordPage
  post 'resetpassword' => 'users#resetpass', as: :userResetPassword

  #Admin
  get 'users/index' => 'users#index', as: :userIndex
  get 'addAdmin' => 'admins#new', as: :addAdmin #display create admin pageget 'addAdmin' => 'admins#new', as: :addAdmin #display create admin page
  get 'admins/editprofile' => 'users#edit#:id',as: :editAdminProfile
  get 'admins/manage' => 'admins#manage' , as: :adminManage
  get 'admins/index' => 'admins#index', as: :adminDashboard
  post 'users/ban/:id' => 'users#ban', as: :banUsers
  post 'users/unban/:id' => 'users#unban', as: :unbanUsers
  get 'admins/changepass' => 'users#changepass#:id', as: :adminChangePassword
  post 'users/destroy/(:id)' => 'users#destroy', as: :deleteAdmin

  # user_shipping_addresses routes
  get 'user_shipping_addresses/index' => 'user_shipping_addresses#index', as: :manageShippingAddress # get user shipping address
  get 'user_shipping_addresses/new' => 'user_shipping_addresses#new', as: :addShippingAddress # new user shipping address
  get 'user_shipping_addresses/edit' => 'user_shipping_addresses#edit', as: :editShippingAddress # edit user shipping address
  post 'user_shipping_addresses/update/(:id)' => 'user_shipping_addresses#update', as: :updateShippingAddress # update user shipping address
  get 'user_shipping_addresses/destroy' => 'user_shipping_addresses#destroy', as: :deleteShippingAddress # update user shipping address

  #Project Proposal
  get 'GetStarted' => 'project_proposals#new', as: :newProposal # display create proposal page
  post 'GetStarted' => 'project_proposals#create', as: :createProposal # process creation of proposal
  get  'project_proposals/show/:id' => 'project_proposals#show', as: :showProjectProposal
  get 'project_proposals/index' => 'project_proposals#index', as: :indexProposaladmin #view index of proposal of projects
  post 'project_proposals/accept/(:id)' => 'project_proposals#accept', as: :approveProposal
  post 'project_proposals/reject/(:id)' => 'project_proposals#reject', as: :rejectProposal
  get 'project_proposals/successProposal/:id' => 'project_proposals#successProposal', as: :successProposalSubmission #success page after getstarted
  post 'project_proposals/manage' => 'project_proposals#manage', as: :checkProposalStatus # display create proposal page
  get 'users/manage/(:id)' => 'users#manage', as: :manageProject # display create proposal page

  #Project Pro
  get 'UploadImg' => 'project_proposal_imgs#new', as: :newCoverImgs
  post 'project_proposal_imgs/create' => 'project_proposal_imgs#create', as: :addCoverImgs # display create proposal page
  post 'project_proposal_imgs/destroy/(:id)'=> 'project_proposal_imgs#destroy', as: :deleteCoverImgs # display create proposal page

  #Project Metrics routes
  get 'projects/rewards_selected/:id' => 'projects#rewards_selected', as: :showRewardsSelected
  get 'projects/funders_details/:id' => 'projects#funders_details', as: :showFundersDetails  

  #Projects Routes
  post 'projects/updateCategory/(:id)' => 'projects#updateCategory', as: :updateCategory
  get 'projects/show/:id' => 'projects#show', as: :showProject
  get 'projects/index' => 'projects#index', as: :projectsIndex
  post 'projects/updateDescription/(:id)' => 'projects#updateDescription', as: :updateDescription
  post 'projects/updateTitle/(:id)' => 'projects#updateTitle', as: :updateTitle
  post 'projects/updateMember/(:id)' => 'projects#updateMemberDetails', as: :updateMemberDetails
  post 'projects/addMembers' => 'projects#addMembers', as: :addMembers
  post 'projects/liveProjectRequests/(:id)' => 'projects#liveProjectRequest', as: :liveProjectRequest

  # user expertises routes
  get 'user_expertises/index' => 'user_expertises#index', as: :allExpertise
  get 'user_expertises/new' => 'user_expertises#new', as: :newExpertise
  post 'user_expertises/create' => 'user_expertises#create', as: :createExpertise

  # project rewards routes
  get 'project_rewards/index' => 'project_rewards#index', as: :projectRewardsIndex
  get 'project_rewards/edit' => 'project_rewards#edit'
  get 'project_rewards/new' => 'project_rewards#new'
  post 'project_rewards/create' => 'project_rewards#create', as: :createProjectReward
  post 'project_rewards/destroy/(:id)' => 'project_rewards#destroy'

  # project updates routes
  get 'project_updates/index' => 'project_updates#index'
  get 'project_updates/edit' => 'project_updates#edit'
  get 'project_updates/new' => 'project_updates#new'
  post 'project_updates/create' => 'project_updates#create', as: :createProjectUpdate
  post 'project_updates/destroy/(:id)' => 'project_updates#destroy'

  #Explore routes
  get 'explores/index' => 'explores#index', as: :viewAllProject  
  get 'explores/filterProjects' => 'explores#filterProjects', as: :viewFilterProject
  get 'explores/show/(:id)' => 'explores#show', as: :viewProject
  get 'explores/message/(:id)' => 'explores#message', as: :messageMember
  # payment for project rewards route
  get 'payments/new' => 'payments#new', as: :makePayment
  post 'payments/create' => 'payments#create', as: :processPayment
  post "/hook" => "payments#hook"

  # project reward backers routes
  get 'project_reward_backers/index' => 'project_reward_backers#index',  as: :projectRewardBackersIndex
  get 'project_reward_backers/new' => 'project_reward_backers#new'
  get 'project_reward_backers/edit' => 'project_reward_backers#edit'
  post 'project_reward_backers' => 'project_reward_backers#create'
  post 'project_reward_backers/destroy/(:id)' => 'project_reward_backers#destroy'

  # project members routes
  get 'project_members/index' => 'project_members#index', as: :projectMembersIndex
  get 'project_members/new' => 'project_members#new'
  get 'project_members/edit/:id' => 'project_members#edit'
  post 'project_members' => 'project_members#create'
  post 'project_members/destroy/(:id)' => 'project_members#destroy'

  #project milstone
  get 'project_milestones/new' => 'project_milestones#new'
  get 'project_milestones/index' => 'project_milestones#index'
  post 'project_milestones' => 'project_milestones#create', as: :createProjectMilestone
  get 'project_milestones/edit' => 'project_milestones#edit'
  post 'project_milestones/destroy/(:id)' => 'project_milestones#destroy'

  #project inspiration
  get 'project_inspirations/new' => 'project_inspirations#new'
  get 'project_inspirations/index' => 'project_inspirations#index'
  get 'project_inspirations/edit' => 'project_inspirations#edit'
  post 'project_inspirations' => 'project_inspirations#create'
  post 'project_inspirations/destroy/(:id)' => 'project_inspirations#destroy'


  match '/:controller/:action/(:id)', via: [:get, :post] # last route
  resources :user_shipping_addresses


end

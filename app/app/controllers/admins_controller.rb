class AdminsController < ApplicationController
  before_filter :logged_in,:authorize_admin, only: [:index,:show ,:new]
  def index
    @current_User = User.find(session[:user_id])
    @ProjectProposals = ProjectProposal.order('project_proposals.created_at DESC').all
    @ProjectOnLive = Project.where(:project_status_id => 7).count()
    @paymentRaised = Payment.sum(:amount)
    @targetAmt = ProjectMilestone.sum(:target_amount)
    @noOfUsers = User.count(:id)
  end

  def new
   @user = User.new  	
  end
end

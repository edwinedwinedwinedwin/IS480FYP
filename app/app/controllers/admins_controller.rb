class AdminsController < ApplicationController
  before_filter :logged_in,:authorize_admin, only: [:index,:show]
  def index
  	@session=session[:user_id]
    @ProjectProposals = ProjectProposal.order('project_proposals.created_at DESC').all
  end

  def new
   @user = User.new  	
  end
end

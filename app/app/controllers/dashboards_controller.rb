class DashboardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
		@current_User = User.find(session[:user_id])

		if @current_User.nil?
			@projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id => @current_User.id})
			@project_coverImgs = ProjectProposalImg.select('
  							project_proposal_imgs.project_proposal_id as pp_id,
  							project_proposal_imgs.id as ppi_id,
  							project_proposals.title as title,
  							projects.id as p_id
  							').joins(project_proposal: :project).where(:projects => {:user_id => @current_User.id})
		end

  end
end

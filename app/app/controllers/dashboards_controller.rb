class DashboardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
		@current_User = User.find(session[:user_id])
		if !session[:user_id].nil?

			@projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id => session[:user_id]})
			@project_coverImgs = ProjectProposalImg.select('
  							project_proposal_imgs.project_proposal_id as pp_id,
  							project_proposal_imgs.id as ppi_id,
  							project_proposals.title as title,
  							projects.id as p_id
  							').joins(project_proposal: :project).where(:projects => {:user_id => session[:user_id]})
		end
  end
end

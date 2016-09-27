class DashboardsController < ApplicationController
  before_filter :logged_in,:authorize_user
  def index
  	@session=session[:user_id]
  	@projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
  	@project_coverImgs = ProjectProposalImg.select('
  							project_proposal_imgs.project_proposal_id as pp_id,
  							project_proposal_imgs.id as ppi_id,
  							project_proposals.title as title,
  							projects.id as p_id
  							').joins(project_proposal: :project).where(:projects => {:user_id => @session})

  	@user=User.find(@session) # only able to edit current logged in user
  end
end

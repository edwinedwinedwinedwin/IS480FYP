class ProjectProposalImgsController < ApplicationController
  before_filter :logged_in,:authorize_user

  def new
    @projectProposalImg = ProjectProposalImg.new

    @project_id = params[:project_id]
    @project_proposal_id = params[:project_proposal_id]
  end

  def create

    @projectProposalImg = ProjectProposalImg.new( project_proposal_img_params)
    @projectProposalImg.save
    redirect_to showProject_path(:id => params[:project_id])

  end

  def destroy
    @projectProposalImg =ProjectProposalImg.find(params[:id])
    @projectProposalImg.destroy
    redirect_to showProject_path(:id => params[:project_id])
  end

  private
  def project_proposal_img_params
    params.require(:project_proposal_img).permit(:img_url, :project_proposal_id)
  end
end

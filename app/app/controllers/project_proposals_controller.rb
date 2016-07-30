class ProjectProposalsController < ApplicationController

  def index
    @ProjectProposals = ProjectProposal.all
  end

  def new
    @ProjectProposal = ProjectProposal.new

  end

  def create
    @ProjectProposal = ProjectProposal.new(params_pp)
    @ProjectProposal.project_status_id = 1
    # Temporary link to "Fundraise" for project_type_id. Sort this out later.
    @ProjectProposal.project_type_id = 1

    if @ProjectProposal.save
      redirect_to root_path and return
    else
      render 'new' and return
    end
  end

  private
  def params_pp
    params.require(:project_proposal).permit(:title, :description, :project_category_id, :project_type_id, :name, :email, :contact_number)
  end
end

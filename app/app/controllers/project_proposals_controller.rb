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

    #Temporary for now
    @ProjectProposal.project_type_id = 1

    if @ProjectProposal.save
      redirect_to :controller=>'ProjectProposals', :action=>'success' and return
    else
      render 'new' and return
    end
  end

  def success
    render 'success' and return
  end

  def accept
    @ProjectProposal=ProjectProposal.find(params[:id])
    @ProjectProposal.project_status_id == 3
    @ProjectProposal.save
    redirect_to :controller => 'ProjectProposal', :action => 'index'    
  end

  def reject
    @ProjectProposal=ProjectProposal.find(params[:id])
    @ProjectProposal.project_status_id == 4
    @ProjectProposal.save
    redirect_to :controller => 'ProjectProposal', :action => 'index'      
  end


  private
  def params_pp
    params.require(:project_proposal).permit(:title, :description, :project_category_id, :project_type_id, :name, :email, :contact_number)
  end
end

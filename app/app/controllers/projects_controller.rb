class ProjectsController < ApplicationController

  def index
    @Projects = Project.all
  end

  def show
    #About Us
    @project = Project.select("*").joins(:project_proposal).where(:projects => {:id=>params[:id]})

    #Overview
    @project_coverImgs = ProjectProposalImg.select("*").joins(:project_proposal).where(:project_proposals => {:id=> @project.project_proposal.id} )

    #Details
    @project_inspirations = ProjectInspiration.select("*").joins(:project).where(:project_inspirations => {:project_id => params[:id]})
    #Updates
    @project_updates = ProjectUpdate.select("*").joins(:project).where(:project_updates => {:project_id => params[:id]})
    #Team
    @project_members = ProjectMember.select("*").joins(:project).where(:project_members => {:project_id => params[:id]})
    #Fuel
    @project_rewards = ProjectReward.select("*").joins(:project).where(:project_rewards => {:project_id => params[:id]})
    #TimeLine
    @project_milestones = ProjectMilestone.select("*").joins(:project).where(:project_members => {:project_id => params[:id]})

  end

  def new
    @Project = Project.new
  end

  def manage
    @Projects = Project.joins(:project_proposal).where(:project_proposals => {:email=>params[:email],:project_status_id=>3})
  end

  def create
    @Project = Project.new(projects_params)
    if @Project.save
      redirect_to :controller => 'projects', :action => 'index' and return
    else
      render 'new'
    end
  end

  def edit
    @Project = Project.find(params[:id])
  end

  def update
    @Project = Project.find(params[:id])
    if @Project.update(projects_params)
      redirect_to :controller => 'projects', :action => 'index' and return
    else
      render 'edit'
    end
  end

  private
  def projects_params
    params.require(:projects).permit(:start_date, :end_date, :country, :state, :city, :project_status_id, :project_proposal_id, :user_id)
  end
end

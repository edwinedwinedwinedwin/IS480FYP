class ProjectsController < ApplicationController

  def index
    @Projects = Project.all
  end

  def show
    @project = Project.find(params[:id])

    @project_proposal = ProjectProposal.find(@project.project_proposal_id)
    @user = User.find(@project.user_id)
    @project_proposal_imgs = ProjectProposalImg.where(:project_proposal_id => @project_proposal.id)
    @project_inspirations = ProjectInspiration.where(:project_id => params[:id])

    @project_members = ProjectMember.joins(:user).select('project_members.id as pm_id,
                        users.id as user_id,
                        users.bio_url as bio_url,
                        users.instagram_url as instagram_url,
                        users.twitter_url as twitter_url,
                        users.fb_url as facebook_url,
                        project_members.role as role,
                        project_members.project_status_id as member_status,
                        project_members.description as description').where(:project_members => {:project_id => params[:id]})

    @project_updates = ProjectUpdate.where(:project_id => params[:id])
    @project_rewards = ProjectReward.where(:project_id => params[:id])
    @project_milestones = ProjectMilestone.where(:project_id => params[:id])
    #@project_milestones_start = ProjectMilestone.find_by_project_id(params[:id]).first
    #@project_milestones_end = ProjectMilestone.find_by_project_id(params[:id]).last

    @new_reward = ProjectReward.new
  end

  def new
    @Project = Project.new
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

  def updateCategory
    @project_proposal = ProjectProposal.find(params[:id])
    @project_proposal.project_category_id = params[:project_category_id]
    @project_proposal.save
    redirect_to showProject_path(params[:project_id]) and return
  end

  def updateDescription
    @project_proposal = ProjectProposal.find(params[:id])
    @project = Project.where(:project_proposal_id => params[:id]).first
    if !params[:project_proposal].nil? && !params[:project_proposal][:description].nil?
      @project_proposal.description = params[:project_proposal][:description]
      @project_proposal.save
    end
    redirect_to showProject_path(@project.id) and return
  end

  def updateTitle
    @project_proposal = ProjectProposal.find(params[:id])
    @project = Project.where(:project_proposal_id => params[:id]).first
    if !params[:project_proposal].nil? && !params[:project_proposal][:title].nil?
      @project_proposal.title = params[:project_proposal][:title]
      @project_proposal.save
    end
    redirect_to showProject_path(@project.id) and return
  end

  private
  def projects_params
    params.require(:projects).permit(:start_date, :end_date, :country, :state, :city, :project_status_id, :project_proposal_id, :user_id)
  end
end

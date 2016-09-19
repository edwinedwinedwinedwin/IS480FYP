class ProjectsController < ApplicationController
before_filter :logged_in,:authorize_user
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
    @new_update = ProjectUpdate.new
    @session=session[:user_id]

    @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
    @project_coverImgs = ProjectProposalImg.select('
                project_proposal_imgs.project_proposal_id as pp_id,
                project_proposal_imgs.id as ppi_id,
                project_proposals.title as title,
                projects.id as p_id
                ').joins(project_proposal: :project).where(:projects => {:user_id => @session})

  end

  def new
    @Project = Project.new
  end

  def create
    @Project = Project.new(projects_params)
    if @Project.save
      #redirect_to :controller => 'projects', :action => 'index' and return
      redirect_to projectsIndex_path and return
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
      #redirect_to :controller => 'projects', :action => 'index' and return
      redirect_to projectsIndex_path and return
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

  def addMembers

    email1 = params[:project_member][:email1]
    email2 = params[:project_member][:email2]
    email3 = params[:project_member][:email3]
    iMessage =  params[:project_member][:inviteMessages]

    @member1 = checkUserForAddMember(email1, iMessage, params[:project_id])
    @member2 = checkUserForAddMember(email2, iMessage, params[:project_id])
    @member3 = checkUserForAddMember(email3, iMessage, params[:project_id])

    redirect_to showProject_path(params[:project_id]) and return
  end

  def checkUserForAddMember(email, messages, p_id)
    @project_members = ProjectMember.new

    if(!email.nil?)
      user = User.find_by_email(email)
      if(!user.nil?)
        #user is existing
        teamMember = ProjectMember.find_by(:user_id => user.id, :project_id => p_id)
        if(teamMember.nil?)
          #user is not inside this project(allow to add in)
          @project_members.role = 'Team Member'
          @project_members.email = user.email
          @project_members.description = user.last_name + ' ' + user.first_name
          @project_members.second_role = 'Crew'
          @project_members.project_id =  p_id
          @project_members.project_status_id = 2
          @project_members.user_id = user.id
          @project_members.save

        else
          #user is inside this project(not allow to add in)

        end
      else
        #user is not existing

      end
    end
  end

  private
  def projects_params
    params.require(:projects).permit(:start_date, :end_date, :country, :state, :city, :project_status_id, :project_proposal_id, :user_id)
  end
end

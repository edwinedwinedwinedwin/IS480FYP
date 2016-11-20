class ProjectsController < ApplicationController
before_filter :logged_in,:authorize_user, only:  [:manage, :liveProjectRequests, :updateCategory, :updateDescription, :updateMemberDetails, :updateTitle, :addMembers]
before_filter :logged_in,:authorize_admin, only: [:accept ,:reject, :index]

  def index
    @projects = Project.all
  end

  def reject
    @project=Project.find(params[:id])
    @project.project_status_id = 4
    @project.save
    #Send email to user who sign up
   SysMailer.reject_proposal_email(@project).deliver
   redirect_to adminDashboard_path and return
  end

  def accept
   @project=Project.find(params[:id])
   @project.project_status_id = 7
    @project.save
    #Send email to user who sign up
    SysMailer.accept_proposal_email(@project).deliver
    redirect_to adminDashboard_path and return
  end

  def manage
    if !session[:user_id].nil?

      @session = session[:user_id]
      @project_requests = ProjectMember.where(:user_id => @session, :project_status_id => 2)


      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})

      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(@session)
    end
  end

  def show
    @project = Project.find(params[:id])
    session[:project_id] = @project.id
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
                        project_members.sub_description as sub_description,
                        project_members.description as description').where(:project_members => {:project_id => params[:id]})

    @project_updates = ProjectUpdate.order('id DESC').where(:project_id => params[:id])
    @project_rewards = ProjectReward.where(:project_id => params[:id])
    @project_milestones = ProjectMilestone.order('start_date ASC').where(:project_id => params[:id])

  #update the status of milestone
    @project_milestones.each do |pm|
      if pm.end_date < Date.today
        pm.project_status_id = 5
        pm.save
      end
    end

    @current_milestone = ProjectMilestone.order('start_date ASC').where(:project_id => params[:id]).where.not(:project_status_id => 5).first
    @total_target_amount = ProjectMilestone.where(:project_id => params[:id]).sum(:target_amount)

    if !session[:user_id].nil?
      @projectReward = ProjectReward.new
      @ProjectUpdate = ProjectUpdate.new
      @projectMilestone = ProjectMilestone.new
      @session=session[:user_id]

      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
    end
  end

  def new
    @Project = Project.new
  end

  def create
    @Project = Project.new(projects_params)
    if @Project.save
      redirect_to projectsIndex_path and return
    else
      render 'new'
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
    tests = params[:project_proposal]
    test = params[:project_proposal][:description]
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
          @project_members.email = user.email
          @project_members.second_role = 'Crew'
          @project_members.project_id =  p_id
          @project_members.project_status_id = 2
          @project_members.user_id = user.id
          @project_members.save
        end
      else
        #user is not existing

      end
    end
  end

  def updateMemberDetails
    @memberDetails = ProjectMember.find(params[:project_member][:id])
    @memberDetails.role = params[:project_member][:role]
    @memberDetails.description = params[:project_member][:description]
    @memberDetails.sub_description = params[:project_member][:sub_description]
    @memberDetails.save
    redirect_to showProject_path(params[:project_member][:project_id]) and return
  end

  def liveProjectRequests
    @project = Project.find(params[:id])
    @project.project_status_id = 6
    @project.save
    redirect_to showProject_path(params[:id]) and return
  end

  def rewards_selected
    @project = Project.find(params[:id])
    @rewards = ProjectReward.where(:project_id => params[:id])    
    if !session[:user_id].nil?

      @session = session[:user_id]
      @project_requests = ProjectMember.where(:user_id => @session, :project_status_id => 2)


      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})

      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(@session)
    end
  end

  def funders_details
    @project = Project.find(params[:id])
    @payments = Payment.where(:project_id=>params[:id])    
    if !session[:user_id].nil?

      @session = session[:user_id]
      @project_requests = ProjectMember.where(:user_id => @session, :project_status_id => 2)


      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})

      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      @user = User.find(@session)
    end
  end

  private
  def projects_params
    params.require(:projects).permit(:start_date, :end_date, :country,:project_status_id, :project_proposal_id, :user_id)
  end
end

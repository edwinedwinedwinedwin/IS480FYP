class ExploresController < ApplicationController
  def index
    @allProjects = Project.all


    if !session[:user_id].nil?
      @current_User = User.find(session[:user_id])
      @projects =ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@current_User.id})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @current_User.id})
    end
  end

  def show
    @project = Project.find_by(:id => params[:id])
    user_id=session[:user_id]
    if !user_id.nil?
      @current_User = User.find(user_id)
      checkCreator = ProjectMember.find_by(:user_id => @current_User.id, :project_id => @project.id)
      if !checkCreator.nil?
        redirect_to showProject_path(:id => params[:id])
      end
    end
    
    @project_proposal = ProjectProposal.find(@project.project_proposal_id)
    @project_creator = User.find(@project.user_id)
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
        @project_milestones.project_status_id = 5
        @project_milestones.save
      end
    end

    @current_milestone = ProjectMilestone.order('start_date ASC').where(:project_id => params[:id]).where.not(:project_status_id => 5).first
    @total_target_amount = ProjectMilestone.where(:project_id => params[:id]).sum(:target_amount)

    if !@current_User.nil?

      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@current_User})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @current_User})
      @user = User.find(@current_User)
      @session = @user.id
    end
  end

  def message
    @user = User.find_by(:id => params[:id])
    @project_id = params[:p_id]
  end
end
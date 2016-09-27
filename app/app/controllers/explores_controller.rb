class ExploresController < ApplicationController
  def index
    @projects = Project.all
    @session = session[:user_id]
  end

  def show
    @project = Project.find_by(:id => params[:id])
    @session = session[:user_id]
   	checkCreator = ProjectMember.find_by(:user_id => @session, :project_id => @project.id)
    if !checkCreator.nil?
      redirect_to showProject_path(:id => @project.id)
    end

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
    @project_milestones = ProjectMilestone.where(:project_id => params[:id])

    if !session[:user_id].nil?

     @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                  project_proposal_imgs.project_proposal_id as pp_id,
                  project_proposal_imgs.id as ppi_id,
                  project_proposals.title as title,
                  projects.id as p_id
                  ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
    end
  end
end

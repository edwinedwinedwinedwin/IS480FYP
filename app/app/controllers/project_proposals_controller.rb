class ProjectProposalsController < ApplicationController
  before_filter :logged_in,:authorize_user,  only: [:manage]
  before_filter :logged_in,:authorize_admin, only: [:accept ,:reject, :index]

  def index
    @ProjectProposals = ProjectProposal.all
  end

  def new
    @ProjectProposal = ProjectProposal.new
  end

  def manage
    emailStr = params[:email]
    @ProjectProposals = ProjectProposal.where(email: emailStr)
  end

  def create
    @ProjectProposal = ProjectProposal.new(params_pp)
    @ProjectProposal.project_status_id = 1        
    img_url = params[:project_proposal][:img_url]
    if @ProjectProposal.save
      # upload project proposal images
        img_url.each do |a|
        @ProjectProposalImg = ProjectProposalImg.new(params_pp_img)
        @ProjectProposalImg.project_proposal_id=@ProjectProposal.id
        @ProjectProposalImg.img_url = a
        @ProjectProposalImg.save
      end
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
    @ProjectProposal.project_status_id = 3
    @ProjectProposal.save

    #Project will create
    @user = User.find_by_email(@ProjectProposal.email)
    @project = Project.new
    @project.project_status_id = 1
    @project.project_proposal_id = @ProjectProposal.id
    if (@user.blank?)
      @project.user_id = @user.id
    end
    @project.save

    #Project Creator will create

    @projectMember = ProjectMember.new
    @projectMember.role = "Founder"
    @projectMember.second_role = "Creator"
    @projectMember.project_id = @project.id
    @projectMember.project_status_id = 3

    if (@user.blank?)
      @projectMember.user_id = @user.id
    end
    @projectMember.save


    #Send email to user who sign up
    SysMailer.accept_proposal_email(@ProjectProposal).deliver
    redirect_to :controller => 'ProjectProposals', :action => 'index'    
  end

  def reject
    @ProjectProposal=ProjectProposal.find(params[:id])
    @ProjectProposal.project_status_id = 4
    @ProjectProposal.save
    #Send email to user who sign up
    SysMailer.reject_proposal_email(@ProjectProposal).deliver
    redirect_to :controller => 'ProjectProposals', :action => 'index'      
  end


  private
  def params_pp
    params.require(:project_proposal).permit(:title, :description, :project_category_id,:project_type_id,:name, :email, :contact_number)
  end

  def params_pp_img
    params.permit(:project_proposal_img).permit(:img_url)
  end



end

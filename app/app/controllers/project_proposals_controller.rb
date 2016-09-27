class ProjectProposalsController < ApplicationController
  before_filter :logged_in,:authorize_user,  only: [:manage]
  before_filter :logged_in,:authorize_admin, only: [:accept ,:reject, :index]

  def index
    @ProjectProposals = ProjectProposal.all
  end

  def new
    @session =session[:user_id]
    @ProjectProposal = ProjectProposal.new
    if !@session.nil?
      @projects=ProjectProposal.select("*").joins(:project).where(:projects => {:user_id=>@session})
      @project_coverImgs = ProjectProposalImg.select('
                project_proposal_imgs.project_proposal_id as pp_id,
                project_proposal_imgs.id as ppi_id,
                project_proposals.title as title,
                projects.id as p_id
                ').joins(project_proposal: :project).where(:projects => {:user_id => @session})
      #@project_coverImgs = ProjectProposalImg.select("*").joins(:project_proposal).where(:project_proposal_imgs => {:project_proposal_id => @project.project_proposal_id} )

      @user=User.find(@session) # only able to edit current logged in user
    end

  end

  def manage
    emailStr = params[:email]
    @ProjectProposals = ProjectProposal.where(email: emailStr)
  end

  def create
    @ProjectProposal = ProjectProposal.new(params_pp)
    @ProjectProposal.project_status_id = 2
    @ProjectProposal.country=params[:project_proposal][:country]
    img_url = params[:project_proposal][:img_url]    
    if @ProjectProposal.save
      # upload project proposal images
        if img_url.present?
          img_url.each do |a|
          @ProjectProposalImg = ProjectProposalImg.new(params_pp_img)
          @ProjectProposalImg.project_proposal_id=@ProjectProposal.id
          @ProjectProposalImg.img_url = a
          @ProjectProposalImg.save
        end
      end
      SysMailer.new_proposal_email(@ProjectProposal).deliver
      redirect_to successProposalSubmission_path(:id => @ProjectProposal.id)
    else
      render 'new'
    end
  end

  def show
    @ProjectProposal = ProjectProposal.find(params[:id])
  end

  def successProposal
    @ProjectProposal = ProjectProposal.find(params[:id])
  end

  def accept
    @ProjectProposal=ProjectProposal.find(params[:id])
    @ProjectProposal.project_status_id = 3
    @ProjectProposal.save

    # Project Proposal will be added to Projects table
    @user = User.find_by_email(@ProjectProposal.email)
    @new_password=Array.new(8){[*'0'..'9', *'a'..'z', *'A'..'Z'].sample}.join # generate random password

    # Automatically create account for user who submitted project proposal if user not registered
    if !@user.blank?            
      SysMailer.accept_proposal_email(@ProjectProposal).deliver    
    else          
      #@new_password_digest=BCrypt::Password.create(@new_password, :cost => 11) # generate password digest      
      @user=User.new
      @user.first_name=@ProjectProposal.first_name
      @user.last_name=@ProjectProposal.last_name
      @user.email=@ProjectProposal.email
      @user.password=@new_password      
      @user.password_confirmation=@new_password      
      @user.is_banned = 0
      @user.is_admin = 0
      @user.country=@ProjectProposal.country
      @user.save
      #Send acceptance email to user who sign up containing new account password
      SysMailer.accept_new_proposal_email(@new_password,@ProjectProposal).deliver  
    end

    @project = Project.new
    @project.project_status_id = 1
    @project.project_proposal_id = @ProjectProposal.id
    @project.country = @user.country
    @project.user_id = @user.id
    @project.save
 # Project Founder will be assigned to person who submitted project proposal
    @ProjectMember = ProjectMember.new
    @ProjectMember.role = 'Founder'
    @ProjectMember.email = @user.email
    @ProjectMember.description = 'Description'
    @ProjectMember.sub_description ='Sub Description'
    @ProjectMember.second_role = 'Creator'
    @ProjectMember.project_id = @project.id
    @ProjectMember.project_status_id = 3
    @ProjectMember.user_id = @user.id    
    @ProjectMember.save    

    redirect_to adminDashboard_path and return
  end

  def reject
    @ProjectProposal=ProjectProposal.find(params[:id])
    @ProjectProposal.project_status_id = 4
    @ProjectProposal.save
    #Send email to user who sign up
    SysMailer.reject_proposal_email(@ProjectProposal).deliver
    redirect_to adminDashboard_path and return     
  end

  private
  def params_pp
    params.require(:project_proposal).permit(:title, :description, :project_category_id,:first_name,:last_name, :email, :contact_number,:country)
  end

  def params_pp_img
    params.permit(:project_proposal_img).permit(:img_url)
  end
end